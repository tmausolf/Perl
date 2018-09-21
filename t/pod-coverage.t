#!perl -T

# use Test::Pod::Coverage tests=>1;
# use lib 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl';

# my @array = ('C:\\Users\\machine_user\\Documents\\Technical References\\Perl');

# use Test::More;
# eval "use Test::Pod::Coverage 1.04";
# plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage" if $@;
# plan tests => 1;
# pod_coverage_ok( "MyModulino", "MyModulino is covered" );
# all_pod_coverage_ok();
# all_pod_coverage_ok( @array );

#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

use Pod::Coverage qw( );

my $script = 'MyModulino';
my $file_path = 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl';


{
    package MyModulino;
    local $ENV{NO_RUN} = 1;
    do "$file_path" or die $@;
}

my $pc = Pod::Coverage->new(
   package  => "$script",
   pod_from => "$file_path",
);

# P::C expects "require the_script;" to succeed.
$INC{$script . ".pm"} = 1;

my $coverage = $pc->coverage();
die $pc->why_unrated()
   if !defined($coverage);

ok($coverage)
   or diag("Not covered: ".join(', ', $pc->naked()));

1;