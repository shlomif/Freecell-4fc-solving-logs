#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use File::Basename (qw( basename dirname ));
use File::Temp (qw/ tempfile tempdir /);
use File::Path (qw/ rmtree mkpath /);

use IO::All qw / io /;

my @unsolved_amateur_star = sort { $a <=> $b } map { /\AUnsolved Board No. ([0-9]+) at/ ? ($1) : () } io('fc-solve-l-amateur-star-100M+1-to-1000M.total.dump')->chomp->getlines;

my $num_unsolved_amateur_star = @unsolved_amateur_star;

my $total = 900_000_000;

my $solved_amateur_star = $total - $num_unsolved_amateur_star;

print "Out of $total deals, Amateur Star:\n\t - solved $solved_amateur_star deals\n\t - left $num_unsolved_amateur_star as indetermined.\n\n";

# print "@unsolved_amateur_star";
