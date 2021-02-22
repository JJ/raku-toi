use Test;

use Toi;
use Toi::Data::Files;

my $prefix = "tmp";
my $data = Toi::Data::Files.new( :$prefix );

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

unlink( <tmp-nick.dat tmp-nock.dat> );
done-testing;
