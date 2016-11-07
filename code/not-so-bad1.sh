#!/bin/sh

compteur=0

ls -l /bin > /tmp/ls-l.tmp
while read line; do
	compteur=$(( compteur + 1 ))
done < /tmp/ls-l.tmp

printf "Il y a %d fichiers dans /bin\n" ${compteur}
