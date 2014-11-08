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

my $fh = io('|commify');
$fh->print ( "Out of $total deals, Amateur Star:\n\t - solved $solved_amateur_star deals\n\t - left $num_unsolved_amateur_star as indetermined.\n\n" );

my @tfts_solved = io('After-toons-for-twenty-somethings/solved.txt')->chomp->getlines;
my @tfts_impossible = io('After-toons-for-twenty-somethings/unsolved.txt')->chomp->getlines;
my @tfts_to_check = io('After-toons-for-twenty-somethings/to-check.txt')->chomp->getlines;

my $tfts_solved = $solved_amateur_star + @tfts_solved;
my $tfts_impossible = @tfts_impossible;

$fh->print( "Toons-for-twenty-somethings deteremined:\n\t- solved $tfts_solved (total)\n\t- impossible $tfts_impossible\n\t- to check @{[scalar @tfts_to_check]}\n\n" );

# print "@unsolved_amateur_star";
my @dbm_solved = io('dbm-solver-summary/solved.txt')->chomp->getlines;
my @dbm_impossible = io('dbm-solver-summary/unsolved.txt')->chomp->getlines;
my @dbm_to_check = io('dbm-solver-summary/to-check.txt')->chomp->getlines;

my $dbm_solved = $tfts_solved + @dbm_solved;
my $dbm_impossible = $tfts_impossible + @dbm_impossible;

$fh->print( "DBM solver deteremined:\n\t- solved $dbm_solved (total)\n\t- impossible $dbm_impossible (total)\n\t- to check @{[scalar @dbm_to_check]}\n\n" );

my @pats_solved = map { $_->name =~ /\/([0-9]+)\.sol\z/ ? ($1) : () } io("./patsolve-results/")->all_files;

my $pats_solved = $dbm_solved + @pats_solved;
my $pats_impossible = $dbm_impossible;

$fh->print( "Patsolve solver deteremined:\n\t- solved $pats_solved (total)\n\t- impossible $pats_impossible (total)\n\t- to check 1\n\n" );

my $hand_solved = $pats_solved + 1;
my $hand_impossible = $pats_impossible;

$fh->print( "Human/Computer assisted solving deteremined:\n\t- solved $hand_solved (total)\n\t- impossible $hand_impossible (total)\n\t- to check 0\n\n" );
