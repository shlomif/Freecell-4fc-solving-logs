#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2700;
use Test::Differences qw(eq_or_diff);

{
    # TEST:$n=900;
    foreach my $fn (glob('logs/*.dump'))
    {
        my $re = qr#\Alogs/freecell4-dump==([0-9]+)-to-([0-9]+)==\.dump\z#;

        # TEST*$n
        like ($fn,
            $re,
            "Filename for '$fn' matches",
        );

        my ($start, $finish) = ($fn =~ $re);
        # TEST*$n
        is ($start%1_000_000, 1, "Mod of start");

        # TEST*$n
        is ($finish, $start+1_000_000-1, "Finish is the last");
    }
}

