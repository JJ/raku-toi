use Test;

use Toi;

my $temp-file-name = "/tmp/data.yaml";
my $temp-file = IO::Path.new( $temp-file-name );

my $data = Toi::Data::YAML.new( :file-name($temp-file-name) );

my $toi = Toi.new: :$data;

$toi.check-in( "nick", 3, 3);

my @dates = $toi.get-days();
ok( @dates, "A non-null amount of dates");
is( @dates.elems, 1, "There's only one");
is( @dates[0], now.Date.Str, "Date is today"); # Don't test by midnight


$temp-file.unlink;
done-testing;
