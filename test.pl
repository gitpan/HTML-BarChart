#!/usr/bin/perl
use HTML::BarChart;
my $test = HTML::BarChart->new("Test Chart",300,100);
$test->bar("t1",30,"#BBBBAA");
$test->bar("t2",50,"#AAAA99");
$test->bar("t3",25,"#999988");
$test->bar("t4",94,"#888877");
$test->bar("t5",124,"#777766");
$test->bar("t6",11,"#666655");

my $this = $test->return;
die("This is broken") if (!defined($this));
undef($this);
undef($test);

