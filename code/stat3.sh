#!/bin/sh

scriptname=$(basename $0)

dohelp() {
    cat << DOHELP
${scriptname} [-h] : this text
${scriptname} [options] file file\ldots : stats
options:
    -s N : number of most important hours, default 5
    -b : for each hours
DOHELP
    exit 0
}
onerror() {
    local exit_code=$1
    shift
    local error_msg="$@"

    echo "ERROR: $error_msg" 1>&2
    exit "$exit_code"
}

size=5
byhour="cut -d ':' -f 1"
is_byhour=0
after=""

set_size() {
    [ "$1" -lt 1 ] && onerror 3 "size must be > 1"
    size=$1
}
set_byhour() {
    byhour="${byhour} | tr -s ' ' | cut -d ' ' -f 3"
    after=" | sort -k 2"
    is_byhour=1
	set_size 24
}
doit() {
    cmd="cat $@ | ${byhour} | sort | uniq -c | sort -nr | head -n ${size} ${after}"
    case ${is_byhour} in
        0)
            printf "%-7.7s %-6.6s %-2.2s\n" "occurences" "date" "hour"
            printf "%-17.17s\n" "-----------------------------------"
            ;;
        1)
            printf "%-7.7s %-2.2s\n" "occurences" "hour"
            printf "%-10.10s\n" "-----------------------------------"
            ;;
    esac
    eval "${cmd}"
}

# [ $# -eq 0 ] && dohelp

[ $# -eq 0 ] && echo "you need arguments" && dohelp

while getopts "s:bh" opt
do
    case $opt in
        h)
            dohelp
            ;;
        s)
            set_size "$OPTARG"
            ;;
        b)
            set_byhour
            ;;
        :)
            onerror 2 "$OPTARG needs a parameter"
            ;;
        \?)
            onerror 7 "option $OPTARG is unknown"
            ;;
    esac
done

shift $((OPTIND-1))
doit "$@"
