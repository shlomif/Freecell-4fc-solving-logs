#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use File::Basename (qw( basename dirname ));
use File::Temp (qw/ tempfile tempdir /);
use File::Path (qw/ rmtree mkpath /);

use IO::All qw / io /;

print map { "$_\n" } sort { $a <=> $b }
    (
    io('dbm-solver-summary/unsolved.txt')->chomp->getlines,
    io('After-toons-for-twenty-somethings/unsolved.txt')->chomp->getlines
);
