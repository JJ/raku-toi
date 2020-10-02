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

method add(Date $date, Str $nick, UInt $x, UInt $y) {
    my %data;
    if $!file-name.IO.e {
        %data = load-yaml($!file-name.IO.slurp);
    }
    my $date-key = $date.Str;
    %data{$date-key}<nick> = { :$x, :$y };
    $!file-name.IO.spurt( save-yaml( %data ));
}
