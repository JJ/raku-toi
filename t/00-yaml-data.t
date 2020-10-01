use Test;

use Toi::Data::YAML;

my $temp-file-name = "/tmp/data.yaml";
my $temp-file = IO::Path.new( $temp-file-name );

my $data-in-yaml = Toi::Data::YAML.new( :file-name($temp-file-name) );

throws-like { $data-in-yaml.load }, X::Toi::NoFile,
        "Correctly throws if no file is present";

$data-in-yaml.add( now.Date, "nick", 3, 3);
my $data = $data-in-yaml.load;

ok( $data, "There's some data");
is( $data.elems, 1, "There's only one");
is( $data[0]<x>, 3, "Roundtrips well");
$temp-file.unlink;
done-testing;
