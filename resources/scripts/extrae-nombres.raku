#!/usr/bin/env raku

# Use zef install IO::Glob to install this

use IO::Glob;

constant $prefix = "toi-";

my %date;

for glob("$prefix*.dat") -> $file {
    my $nick = $file.path ~~ /"$prefix" (.+) ".dat"/;
    my ($date,$name) = $file.slurp.split( /\s+ "=" \s+ / );
    %date{$date}.push: "$nick[0]:$name";
}

for %date.keys -> $d {
    say $d;
    for %date{$d}[] -> $n {
        say $n
    }
}

