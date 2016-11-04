#!/bin/sh

scriptname=$(basename $0)

dohelp() {
    cat << DOHELP
${scriptname} [-h|--help] : this text
${scriptname} file file\ldots : stats
DOHELP
    exit 0
}

[ $# -eq 0 ] && dohelp
case $1 in
    -h | --help)
        dohelp
        ;;
    *)
        cat "$@" | \
            cut -d ':' -f 1 | \
                sort | \
                    uniq -c | \
                        sort -n
        ;;
esac
