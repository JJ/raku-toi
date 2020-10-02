use Test;

use Toi;

my $temp-file-name = "/tmp/data.yaml";
my $temp-file = IO::Path.new( $temp-file-name );

my $data = Toi::Data::YAML.new( :file-name($temp-file-name) );

my $toi = Toi.new: :$data;

sleep 61 if DateTime.now.minute == 59;
$toi.check-in( "nick", 3, 3);

my $today = now.Date;
my @dates = $toi.get-days();
ok( @dates, "A non-null amount of dates");
is( @dates.elems, 1, "There's only one");
is( @dates[0], $today.Str, "Date is today");

my %today-check-ins = $toi.get-check-ins( $today );
ok(%today-check-ins, "We have a check-in hash for today");
is(%today-check-ins<nick><x>, 3, "Position x correct for check-in");
is(%today-check-ins<nick><y>, 3, "Position y correct for check-in");

$toi.check-in( "nock", 4, 4);
@dates = $toi.get-days();
is( @dates.elems, 1, "Still only one");
%today-check-ins = $toi.get-check-ins( $today );
is(%today-check-ins.keys.elems, 2, "Two nicks have checked in");
is(%today-check-ins<nock><x>, 4, "Position x correct for check-in");
is(%today-check-ins<nock><y>, 4, "Position y correct for check-in");
$temp-file.unlink;

done-testing;
