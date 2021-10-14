#!/bin/bash

echo "SHOOTING STAR"
echo "SCRIPTED BY GOBINATH "


if [ -z "$1" ]
then
 
      echo "Usage : ./bash_automation <IP>"
      exit 1
fi

printf "\n----------- Nmap -----------\n\n" > results

echo "Running Nmap..."

nmap $1 | tail -n +5 | head -n -3 >> results

while read line

do
     if [[ $line == *open* ]] && [[ $line == *http* ]]
     then

            echo "Running Whatweb..."
            whatweb $1 -v > temp1

            echo "Running Gobuster..."
            gobuster dir -u $1 -w /usr/share/wordlists/dirb/common.txt -qz > temp2
     fi
done < results

if [ -e temp1 ]
then
      printf "\n--------web--------\n\n"
        cat temp1 >> results
        rm temp1
fi

if [ -e temp2 ]
then

   printf "\n---------DIRS--------\n\n"
   cat temp2 >> results
   rm temp2
fi

cat results
