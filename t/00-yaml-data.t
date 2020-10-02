use Test;

use Toi::Data::YAML;

my $temp-file-name = "/tmp/data.yaml";
my $temp-file = IO::Path.new( $temp-file-name );

my $data-in-yaml = Toi::Data::YAML.new( :file-name($temp-file-name) );

throws-like { $data-in-yaml.load }, X::Toi::NoFile,
        "Correctly throws if no file is present";

my $date = now.Date;
$data-in-yaml.add( $date, "nick", 3, 3);
my %data = $data-in-yaml.load;

ok( %data, "There's some data");
is( %data.keys.elems, 1, "There's only one");
is( %data{$date.Str}<nick><x>, 3, "Roundtrips well");

$data-in-yaml.add( $date, "nick", 4, 4);
%data = $data-in-yaml.load;
is( %data{$date.Str}<nick><x>, 4, "Uses latest check-in");

$temp-file.unlink;
done-testing;
