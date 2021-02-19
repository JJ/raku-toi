use Toi::Data;
use X::Toi;

unit class Toi::Data::Files does Toi::Data;

has $.prefix = "toi";

method load( --> Associative ) {
    return;
}

multi method add(Date $date, Str $nick, UInt $x, UInt $y) {
    self!add-anything(  $date, $nick,{:$x, :$y} );
}

multi method add(Date $date, Str $nick, Str $payload ) {
    self!add-anything(  $date,  $nick, $payload );
}

method !add-anything( Date $date, Str $nick, $payload ) {
    my %data;
    my $date-key = $date.Str;
    my $file-name = $nick ?? $nick !! $payload.subst(" ","_");
    "$!prefix-$file-name.dat".IO.spurt( "$date-key = $payload" );
}
