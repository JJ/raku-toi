#!/usr/bin/env raku

# Use zef install IO::Glob to install this

use IO::Glob;

constant $prefix = "toi-";

my %date;

for glob("$prefix*.dat") -> $file {
    my ($date,$name) = $file.slurp.split( /\s+ "=" \s+ / );
    %date{$date}.push: $name;
}

for %date.keys -> $d {
    say $d;
    for %date{$d}[] -> $n {
        say $n
    }
}

