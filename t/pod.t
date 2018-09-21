#!perl -T

# This test file will test that all of the pod in any files with a .pm or a 
# .pl extension in the distribution have syntactically correct pod.

#use lib (
#  'C:\\Strawberry\\perl\\lib', 
#  'C:\\Strawberry\\perl\\site\\lib',
#  'C:\\Strawberry\\perl\\vendor\\lib'
#);

#my @array = (
#  'C:\\Strawberry\\perl\\lib', 
#  'C:\\Strawberry\\perl\\site\\lib',
#  'C:\\Strawberry\\perl\\vendor\\lib'
#);

my @array = ('C:\\Users\\machine_user\\Documents\\Technical References\\Perl');
my $file_path = 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl';

# use Test::More;
use Test::More tests => 1;
# use Test::More qw(no_plan);
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
# all_pod_files_ok(@array);
# all_pod_files_ok();
pod_file_ok($file_path);
#done_testing();