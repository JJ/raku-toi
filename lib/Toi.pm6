use Toi::Role;
use Toi::Data::YAML;

unit class Toi does Toi::Role;

has Toi::Data $.data;

proto check-in( Str $nick, | ) {*}

multi method check-in( Str $nick, Str $name ) {
    $!data.add( now.Date, $nick, $name )
}

multi method check-in( Str $nick, UInt $x, UInt $y) {
    $!data.add( now.Date, $nick, $x, $y)
}

method get-check-ins( Date $day ) {
    $!data.load(){$day.Str};
}

method get-days() {
    $!data.load().keys;
}

