#!perl -T
 
use strict;
use warnings;

# lib         Manipulate @INC at compile time
use lib 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl';

require 'MyModulino.pl';
use English qw(-no_match_vars);

# use Test::More tests => 1;
# my $skip_reason = "Not ready to implement.\n";
# use Test::More skip_all => $skip_reason;

use Test::More qw(no_plan);

# Test that modules are available.

require_ok( "MyModulino.pl" ) or bail("MyModulino.pl is required.");
require_ok( "Text::CSV::Simple" );

# Test command line arguments

TODO: {
  local $TODO = "Test perl arguments -i=input_path -o=output_path";
  note($TODO);
}

my $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -i=C:\\Users\\machine_user\\input.txt`;
like($output, qr/field1/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -i=C:\\Users\\machine_user\\input.txt:\n $output");

SKIP: {
  skip "Skip MyModulino.pl -verbose option. This works, but clutters the output using prove -r t/.";
  $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -v -i=C:\\Users\\machine_user\\input.txt`;
  like($output, qr/verbose/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -v -i=C:\\Users\\machine_user\\input.txt:\n $output");
}
SKIP: {
  # Try the arguments with a single dash in front of the commands.
  skip "Skip arguments with a single dash in front of the command, like -help, -man, -usage, and -version. Two dashes in front of the comand is expected.";
  
  $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -help`;
  like($output, qr/help/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -help:\n $output");

  $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -man`;
  like($output, qr/man/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -man:\n $output");

  $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -usage`;
  like($output, qr/usage/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -usage:\n $output");

  $output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -version`;
  like($output, qr/version/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -version:\n $output");
}

# Try the arguments with a double dash in front of the commands.

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" --help`;
like($output, qr/help/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' --help:\n $output");

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" --man`;
like($output, qr/man/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' --man:\n $output");

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" --usage`;
like($output, qr/usage/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' --usage:\n $output");

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" --version`;
like($output, qr/version/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' --version:\n $output");

# Read in a list of files after --.

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -- "C:\\Users\\machine_user\\input.txt" "C:\\Users\\machine_user\\input 2.txt"`;
like($output, qr/Read in a list of input files/, "perl 'C:\\Users\\machine_user\\Documents\\Technical References\\Perl' -- 'C:\\Users\\machine_user\\input.txt' 'C:\\Users\\machine_user\\input 2.txt':\n $output");

# Test MyModulino subs

my ($return_value);
$return_value = MyModulino::display_input_file_argument('C:\\Users\\machine_user\\input.txt');
like($return_value, qr/input file/, 'MyModulino::display_input_file_argument(\'C:\\Users\\machine_user\\input.txt\')');

my @input_files_array = ('C:\\Users\\machine_user\\input.txt', 'C:\\Users\\machine_user\\input2.txt');
$return_value = MyModulino::display_input_file_arguments(\@input_files_array);
like($return_value, qr/input files/i, 'MyModulino::display_input_file_arguments(\@input_files_array)');

$return_value = MyModulino::display_output_file_argument('C:\\Users\\machine_user\\output.txt');
like($return_value, qr/output file/, 'MyModulino::display_output_file_argument(\'C:\\Users\\machine_user\\output.txt\')');

$return_value = MyModulino::display_verbose_argument(1);
like($return_value, qr/verbose/, 'MyModulino::display_verbose_argument(1)');


my $program = 'MyModulino.pl';
my $usage = "perl $program [-i[nfile] [=] C:\\Users\\machine_user\\input.txt ]"
          . '[-o[utfile] [=] C:\\Users\\machine_user\\output.txt ]'
          . '[-v[erbose] ][--help ][--man ][--usage ][--version ]'
          . "[-- C:\\Users\\machine_user\\input.txt [C:\\Users\\machine_user\\input2.txt ...]]\n";
$return_value = MyModulino::display_help($program, $usage);
like($return_value, qr/usage/, 'MyModulino::display_help($program, $usage)');

$return_value = MyModulino::display_manual($program);
like($return_value, qr/man/, 'MyModulino::display_manual($program)');

$return_value = MyModulino::display_usage($usage);
like($return_value, qr/usage/, 'MyModulino::display_usage($usage)');

my $version = '1.0.0';
$return_value = MyModulino::display_version($version);
like($return_value, qr/version/, 'MyModulino::display_version($version)');

my $PROGRAM = 'MyModulino.pl';
my @ARGV = ('MyModulino');
$return_value = MyModulino::display_header({ program=>$PROGRAM, argv=>[@ARGV] });
like($return_value, qr/Arguments/, 'MyModulino::display_header({ program=>$PROGRAM, argv=>[@ARGV] })');

# This works. Can be modified for a test. May not be needed. 
# Pipes are working. You want it to be non-interactive.
my $stdin_is_a_pipe = 1;
my $stdout_is_a_pipe = 0;
my $input_dir = 'C:\\Users\\machine_user\\';
my $test_input_path = 'C:\\Users\\machine_user\\input.txt';
open my $test_fh,  '<', $test_input_path
  or croak( "Cannot open $test_input_path: $ERRNO\n" ); # $!   
my $status = MyModulino::process_piped_input({
  stdin_is_a_pipe=>$stdin_is_a_pipe,
  stdout_is_a_pipe=>$stdout_is_a_pipe,
  input_dir=>$input_dir, 
  file_handle_ref=>\*$test_fh
});
close $test_fh or croak( "Cannot close $test_input_path: $ERRNO\n" );
is($status, 0, 'MyModulino::process_piped_input({
  stdin_is_a_pipe=>$stdin_is_a_pipe,
  stdout_is_a_pipe=>$stdout_is_a_pipe,
  input_dir=>$input_dir, 
  file_handle_ref=>\*$test_fh
  });'
);

# Note: The whole point of this is to make it not interactive for testing 
#       purposes. The file handle is different for testing.
$input_dir = 'C:\\Users\\machine_user\\';
$test_input_path = 'C:\\Users\\machine_user\\input.txt';
open $test_fh,  '<', $test_input_path
  or croak( "Cannot open $test_input_path: $ERRNO\n" ); # $!
my $contents_entered = MyModulino::read_data_from_stdin_into_a_flat_file(
  $input_dir, \*$test_fh
);
close $test_fh or croak( "Cannot close $test_input_path: $ERRNO\n" );
is($contents_entered, 1, 'MyModulino::read_data_from_stdin_into_a_flat_file'
  .'($input_dir, \*$test_fh)');

# DID NOT WORK; NOT A FAILED TEST
#my $hash_ref = MyModulino::process_command_line_options($program);
#my %hash = %{$hash_ref};
#note ('Values in hash %ARGV:');
# foreach my $key (keys %hash) {
#   note("$key => $ARGV{$hash}\n");
# }

# Test pipe input and redirection.

$output = `perl "C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -i="C:\\Users\\machine_user\\input.txt" > output.txt`;
$output = `type output.txt`;
like($output, qr/field1/, "type output.txt:\n $output");

$output = `"C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" < "C:\\Users\\machine_user\\input.txt"`;
like($output, qr/field1/, "'C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl' < 'C:\\Users\\machine_user\\input.txt':\n $output");

$output = `type "C:\\Users\\machine_user\\input.txt" | MyModulino.pl`;
like($output, qr/field1/, "type \"C:\\Users\\machine_user\\input.txt\" | MyModulino.pl:\n $output");

$output = `"C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl" -i="C:\\Users\\machine_user\\input.txt" | sort`;
like($output, qr/field1/, "'C:\\Users\\machine_user\\Documents\\Technical References\\Perl\\MyModulino.pl' -i='C:\\Users\\machine_user\\input.txt' | sort:\n $output");

# This test may not be needed. It is unclear whether anyone will use this approach.
$output = `echo "C:\\Users\\machine_user\\input.txt" "C:\\Users\\machine_user\\input 2.txt" | MyModulino.pl`;
like($output, qr/field1/, "echo 'C:\\Users\\machine_user\\input.txt' 'C:\\Users\\machine_user\\input 2.txt' | MyModulino.pl:\n $output");

done_testing();

# Code coverage

# Good places to test:
# * The minimum and maximum possible values
# * Slightly less that the minimum possible value and slightly more than the 
#   maximum possible value
# * Negative values, positive values, and zero (0)
# * Very small positive and negative values
# * Empty strings and multiline strings ('')
# * Strings with control characters (including "\0")
# * Strings with non-ASCII characters (e.g., Latin-1 or unicode
# * undef, and lists of undef (undef)
# * '0', '0E0', '0.0', and '0 but true' ('0')
# * Empty lists, arrays, and hashes
# * Lists with duplicated and triplicated values
# * Input values that "will never be entered" (but which are)
# * Interactions with resources that "will never be missing" (but which are)
# * Non-numeric input where a number is expected, and vice versa
# * Non-references where a reference is expected and vice versa
# * Missing arguments to a subroutine or method
# * Extra arguments to a subroutine or method
# * Positional arguments that are out of order
# * Key/value arguments that are mislabeled
# * Loading the wrong version of a module, where multiple versions are 
#   installed on your system
# * Every bug you ever actually encounter. Don't try to fix the problem
#   straightaway. Instead, immediately add those tests to your test suite.