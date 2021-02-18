unit role Toi::Data;

method load( --> Associative ) {…}
proto add( Date $date, Str $nick, | ) {*}
multi method add(Date $date, Str $nick, UInt $x, UInt $y) {…}
multi method add(Date $date, Str $nick, Str $payload) {…}
