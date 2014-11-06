#!/bin/bash
cat ~/Arcs/fc-solve/freecell4-up-to-1e9/After-toons-for-twenty-somethings/to-check.txt |
    (while read idx
    do
        echo "== idx=$idx =="
        sol_fn="$idx.sol"
        if ! test -e "$sol_fn"
        then
            board_fn="$idx.board"
            pi-make-microsoft-freecell-board -t "$idx" > "$board_fn"
            ./dbm_fc_solver --num-threads 4 --offload-dir-path "./OFFLOAD/" -o "$sol_fn.sol" "$board_fn" | tee "$sol_fn"
        fi
    done)
