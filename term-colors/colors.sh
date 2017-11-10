#!/bin/bash

T='gYw'   # The test text

echo "Background:      0       1       2       3       4       5       6       7"
echo "Foreground:"

for FG in 0 1 2 3 4 5 6 7
do
echo -en " ${FG}     $(tput setaf ${FG})  $T  "
for BG in 0 1 2 3 4 5 6 7
do 
echo -en "$(tput setaf ${FG})$(tput setab ${BG})  $T  ";
echo -en "$(tput sgr0) "
done
echo
#  Do it again, in bold:
echo -en " ${FG}bold $(tput bold)$(tput setaf ${FG})  $T  "
for BG in 0 1 2 3 4 5 6 7
do 
echo -en "$(tput bold)$(tput setaf ${FG})$(tput setab ${BG})  $T  ";
echo -en "$(tput sgr0) "
done
echo
done
echo
