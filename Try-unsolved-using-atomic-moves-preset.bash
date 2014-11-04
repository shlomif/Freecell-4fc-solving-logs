#!/bin/bash
cat fc-solve-l-amateur-star-100M+1-to-1000M.total.dump | perl -lane 'print $1 if /^Unsolved Board No. (\d+)/' |
    (while read idx
    do
        echo "==[[ idx=$idx ]]=="
        pi-make-microsoft-freecell-board -t "$idx" | fc-solve -l tfts -sam -p -t -sel -mi 3000000
    done)
