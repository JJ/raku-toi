use Toi::Data;
use X::Toi;

use YAMLish;

unit class Toi::Data::YAML does Toi::Data;

has $.file-name = "toi.yaml";

method load( --> Associative ) {
    if $!file-name.IO.e {
        return load-yaml($!file-name.IO.slurp);
    } else {
        X::Toi::NoFile.new( :file-name($!file-name)).throw
    }
}

multi method add(Date $date, Str $nick, UInt $x, UInt $y) {
    self!add-anything(  $date, $nick,{:$x, :$y} );
}

multi method add(Date $date, Str $nick, Str $payload ) {
    self!add-anything(  $date,  $nick, $payload );
}

method !add-anything( Date $date, Str $nick, $payload ) {
     my %data;
    if $!file-name.IO.e {
        %data = load-yaml($!file-name.IO.slurp);
    }
    my $date-key = $date.Str;
    %data{$date-key}{$nick} = $payload;
    $!file-name.IO.spurt( save-yaml( %data ));
}
