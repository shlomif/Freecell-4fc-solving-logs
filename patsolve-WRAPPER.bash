#!/bin/bash
idx="$1"
shift
fn="${idx}.board"
pi-make-microsoft-freecell-board -t "$idx" > "$fn"
ver_fn="${fn}.for-verify"
perl -lan -0777 -E 'print "Foundations: H-0 C-0 D-0 S-0 \nFreecells:" . " " x 16 . "\n" . s/^/: /gmrs' < "$fn" > "$ver_fn"
if ./patsolve -S -f ./"$fn" ; then
    sol_fn="${idx}.sol"
    perl /home/shlomif/progs/freecell/git/fc-solve/cpan/Games-Solitaire-Verify/Games-Solitaire-Verify/script/convert-patsolve-to-fc-solve-solution -g freecell "$ver_fn" "win" > "$sol_fn"
    verify-solitaire-solution -g freecell "$sol_fn"
fi
