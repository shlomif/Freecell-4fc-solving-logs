#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5400;
use Test::Differences qw(eq_or_diff);

use IO::All qw(io);

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

        my $contents = io->file($fn)->all;

        # TEST*$n
        like ($contents, qr/\AStarted at [0-9]+\.[0-9]+\n/,
            "Started '$fn' at.");

        # TEST*$n
        like ($contents, qr/^Finished at [0-9]+\.[0-9]+ \(total_num_iters=[0-9]+\)\n\z/ms,
            "Finished '$fn' at.");

        # TEST*$n
        eq_or_diff(
            [sort { $a <=> $b} $contents =~ /^Reached Board No\. ([0-9]+) at/gms],
            [grep { $_ % 1_000 == 0 } $start .. $finish],
            "Reached boards for '$fn'.",
        )
    }
}

