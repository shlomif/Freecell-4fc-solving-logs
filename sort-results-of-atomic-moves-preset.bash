#!/bin/bash
grep -P '^(==\[\[ idx=|I could not solve this game.|Iterations count exceeded.|This game is solveable.)' atomic-verdicts.txt | \
    perl -MIO::All -E 'while (!eof) { my ($idx) = (<> =~ /idx=([0-9]+)/);io->file("After-toons-for-twenty-somethings/" . {"I could not solve this game." => "unsolved.txt", "Iterations count exceeded." => "to-check.txt", "This game is solveable." => "solved.txt"}->{do { my $s = <> ; chomp$s;$s}})->assert->append("$idx\n") }'
