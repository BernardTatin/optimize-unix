#!/bin/sh

compteur=0

ls -l /bin | while read line; do
	compteur=$(( compteur + 1 ))
done

printf "Il y a %d fichiers dans /bin\n" ${compteur}
