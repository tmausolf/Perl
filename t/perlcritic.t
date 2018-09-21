#!perl

# use Test::Perl::Critic;
use Test::More tests => 1;

# my @array = (
#  'C:\\Strawberry\\perl\\lib', 
#  'C:\\Strawberry\\perl\\site\\lib',
#  'C:\\Strawberry\\perl\\vendor\\lib'
#);

# my @array = ('C:\\Users\\machine_user\\Documents\\Technical References\\Perl');
my $file_path = 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl';

if (!require Test::Perl::Critic) {
    Test::More::plan(
        skip_all => "Test::Perl::Critic required for testing PBP compliance"
    );
}

# Test::Perl::Critic::all_critic_ok( @array );
Test::Perl::Critic::critic_ok($file_path);