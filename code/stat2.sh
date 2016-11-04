#!/bin/sh

scriptname=$(basename $0)

dohelp() {
    cat << DOHELP
${scriptname} [-h|--help] : this text
${scriptname} [options] file file\ldots : stats
options:
    -s|--size N : number of most important hours, default 5
    -b|--byhour : for each hours
DOHELP
    exit 0
}

size=5
byhour="cut -d ':' -f 1"
is_byhour=0
after=""

[ $# -eq 0 ] && dohelp
end=0

while [ $end -eq 0 ]
do
    case $1 in
        -h | --help)
            dohelp
            ;;
        -s | --size)
            shift
            [ $# -eq 0 ] && onerror 2 "$1 needs a parameter"
            size=$1
            shift
            ;;
        -b | --byhour)
            shift
            byhour="${byhour} | tr -s ' ' | cut -d ' ' -f 3"
            after=" | sort -k 2"
            is_byhour=1
            ;;
        *)
            end=1
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
            eval ${cmd}
            ;;
    esac
done
