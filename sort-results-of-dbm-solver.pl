#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use File::Basename (qw( basename dirname ));
use File::Temp (qw/ tempfile tempdir /);
use File::Path (qw/ rmtree mkpath /);

use IO::All qw / io /;

foreach my $f (glob('dbm-solver-results/*.sol.sol'))
{
    my $t = io($f)->all;
    io->file(
        sprintf("dbm-solver-summary/%s.txt",
        ($t =~ /^Success/ms ? "solved"
            : $t =~ /^Could not solve successfully/ms ? "unsolved"
            : "to-check"
        )
    )
    )->assert->append(($f =~ /([0-9]+)/), "\n");
}
