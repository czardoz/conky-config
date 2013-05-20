#!/bin/bash
export http_proxy=http://f2009619:hkhg874@10.1.9.20:8080/

uri=http://feeds.feedburner.com/UpUbuntu?format=xml
lines=4
titlenum=
if [[ "$uri" == "" ]]; then
        echo "No URI specified, cannot continue!" >&2
        echo "Please read script for more information" >&2
else
        #Set defaults if none specified
        if [[ $lines == "" ]]; then lines=25 ; fi
        if [[ $titlenum == "" ]]; then titlenum=2 ; fi

        #The actual work
        curl -s --connect-timeout 30 $uri |\
        sed -e 's/<\/title>/\n/g' |\
        grep -o '<title>.*' |\
        sed -e 's/<title>//' |\
        head -n $(($lines + $titlenum)) |\
        tail -n $(($lines))
fi
