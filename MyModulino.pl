#!C:\Strawberry\perl\bin\perl.exe
# ---------------------------------------------------------------------------
# Running Perl programs
#  To run a Perl program from the command line:
#
#  perl progname.pl [arg1[, arg2...]] # See usage below.
#  echo "C:\\Users\\machine_user\\input 2.txt" "C:\\Users\\machine_user\\input 3.txt" | MyModulino.pl
#  # Use double quotes, not single quotes with type.
#  type "C:\\Users\\machine_user\\input 2.txt" | MyModulino.pl
#  perl MyModulino.pl < "C:\\Users\\machine_user\\input 3.txt"
#
# Run the debugger
#  perl -d progname.pl [arg1[, arg2...]]
#    b 400        set a breakpoint
#    x $variable  examine a variable
#    w $variable  watch a variable
#    v            view where you are in the source
#    c            continue until next breakpoint
#    n            execute next statement
#
# Read program documentation.
#  perldoc progname.pl     # documentation for progname.pm
#  perldoc -l progname.pm  # location of progname.pm
#
# To get coding advice
#  perlcritic --severity 1 MyModulino.pl # get coding tips.
#  perlcritic --verbose 11 --severity 4 MyModulino.pl
#  Themes:bugs, certrec, certrule, complexity, core, cosmetic, maintenance,
#    pbp, performance, portability, readability, security, tests, unicode
#
# To test the test scripts
#  prove -r t/  # easy way
#  prove -vr t/ # verbose way
#
# See more information on warnings and errors.
#  perl -Mwarn=verbose progname.pl
# ---------------------------------------------------------------------------
# You can make things simple and remove decisions.
package MyModulino;

use strict;
use warnings;
# no strict 'vars';

# Getopt::Euclid reads command line options from the embedded documentation.
use Getopt::Euclid;
# Text::CSV::Simple reads CSV input files.
use Text::CSV::Simple;
# List::MoreUtils gives access to the uniq command.
use List::MoreUtils qw(uniq);
# Readonly allows Readonly constants.
use Readonly;
# English replaces dollar sign variables with their english equivalent.
use English qw(-no_match_vars); # exclude -no_match_vars for performance
# warn is used for errors (croak) and warnings (warn)
use Carp;
# Returns true if *ARGV and the currently selected filehandle (usually
# *STDOUT) are connected to the terminal.
use IO::Interactive qw(is_interactive);

# Getopt::Euclid removes the command-line arguments from @ARGV and parses
# them into %ARGV. In scalar context, caller returns the caller's package
# name if there *is* a caller.
if (!caller) { __PACKAGE__->run(@ARGV); }
#__PACKAGE__->run(@ARGV) unless caller;
# run(@ARGV) if !$ENV{NO_RUN};

# Croak:
# Error: Error
# at MyModulino.pl line 189.
#        eval {...} called at MyModulino.pl line 172
#        MyModulino::run("MyModulino") called at MyModulino.pl line 52

# Confess:
# Error: Error
# at MyModulino.pl line 61.
#        MyModulino::__ANON__("Error\x{a}") called at MyModulino.pl line 189
#        eval {...} called at MyModulino.pl line 172
#        MyModulino::run("MyModulino") called at MyModulino.pl line 52

# Wrapping all die calls in a handler routine can be useful to see how,
# and from where, they're being called, perlvar has more information:
BEGIN {
  local $SIG{__DIE__} = sub {
    require warn;
    warn::confess(@_)
  }
}

# our (@ISA, @EXPORT_OK);
BEGIN {
#  require Exporter;
  # TODO: Never make variables part of a module's interface.
  # use vars eliminates the need for full package
  # $MyModulino::return_val.
  use vars qw( $return_val $PROGRAM $USAGE $VERSION $ERROR $SUCCESS
    @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS
  );

  use version;
  # Other pragmas affect the current package instead, like "use
  # vars" and "use subs", which allow you to predeclare a variables or
  # subroutines within a particular *file* rather than just a block. Such
  # declarations are effective for the entire file for which they were
  # declared.
  our $VERSION = qv('1.0.0');

  # @ISA = qw(Exporter);
  # Functions and variables which can be optionally exported
  # symbols to export on request
  # @EXPORT_OK = qw(display_help display_manual display_usage display_version);

  # perldoc Exporter
  # use base qw( Exporter ); # our @ISA = qw(Exporter);
  # If you must export, try to use @EXPORT_OK in preference to @EXPORT
  # Do not export variable names. Just because you can does not mean you
  # should.
  # our @EXPORT = qw( ok );                # Default export  require MyModulino.
  # our @EXPORT_OK = qw( skip pass fail ); # By explicit request only
  # our %EXPORT_TAGS (
  #     ALL => [@EXPORT, @EXPORT_OK],      # Everything if :ALL tagset
  #                                        # requested
  #     TEST => [qw( ok pass fail )],      # These if :TEST tagset requested
  #     PASS => [qw( ok pass )],           # These if :PASS tagset requested
  # );

  # exported package globals go here


  # non-exported package globals go here

  our $return_val = q{};
  our $PROGRAM = $PROGRAM_NAME; # $0
  our $USAGE = "perl $PROGRAM [-i[nfile] [=] "
             . 'C:\\Users\\machine_user\\input.txt ][-o[utfile] [=] '
             . 'C:\\Users\\machine_user\\output.txt ][-v[erbose] ]'
             . '[-h[elp] ][--help ][--man ][--usage ][--version ][/? ]'
             . '[-- C:\\Users\\machine_user\\input2.txt [C:\\Users\\'
             . "machine_user\\input3.txt ...]]\n";
  Readonly our $ERROR => -1;
  Readonly our $SUCCESS => 0;

  # file-private lexicals go here, before any functions which use them

}

# include packages for consistency.
# include error handling for consistency.

# Quick: meet requirements, get it working
# Write a program which accepts a file of json. Better.
# Or, you could treat it like a web service. Not the worst idea.
# TDD
# Filter, consolidate.
# Input: json or simliar. JSON for now. Divergent.
# Output: Conclusion or Action. Convergent.
# - Try to make it systematic.

# Refine your package code. Try to make things reuseable.
# Doesn't have to be perfect.
# ---------------------------------------------------------------------------

# perl                Perl overview (this section)
# perlintro           Perl introduction for beginners
# perlrun             Perl execution and options
# perltoc             Perl documentation table of contents
# perlreftut          Perl references short introduction
# perldsc             Perl data structures intro
# perllol             Perl data structures: arrays of arrays
# perlrequick         Perl regular expressions quick start
# perlretut           Perl regular expressions tutorial
# perlootut           Perl OO tutorial for beginners
# perlperf            Perl Performance and Optimization Techniques
# perlstyle           Perl style guide
# perlcheat           Perl cheat sheet
# perltrap            Perl traps for the unwary
# perldebtut          Perl debugging tutorial
# perlfaq             Perl frequently asked questions
# perlsyn             Perl syntax
# perldata            Perl data structures
# perlop              Perl operators and precedence
# perlsub             Perl subroutines


#############################################################################
# Usage: run(@ARGV);
# Purpose: First subroutine to run. Executes main program logic and deals
#          with errors.
# Returns: N/A
# Parameters: @ARGV
# Throws: main program eval errors. Exits successfully or in error status
#         depending on whether error(s) occurred.
# Comments:
sub run {
  my (@ARGV) = @_;
  #print '@_:' . "@_\n";
  #print '@ARGV:' . "@ARGV\n";
  my $return_value = eval {
    #$return_val = print '@ARGV=' . join(', ', @ARGV) . "\n";
    #$return_val = print '$EVAL_ERROR=' . "$EVAL_ERROR\n";
    #$return_val = print '@_=' . "@_\n";

    # localize $@ before catching an exception. You never know what has
    # reset $@.
    local $EVAL_ERROR = undef;  # $@ eval errors
    local @_ = undef;  # @_ argument
    # To get all the output from your error log, and not miss any messages
    # via helpful operating system buffering, insert a line like this, at the
    # start of your script:
    local $OUTPUT_AUTOFLUSH = 1;  # $|=1;

    # Exit with main's return value: exit (main(@argv));
    main(@ARGV);
  };
  # Error Handling
  if ( my $exception = $EVAL_ERROR ) { # $@
    chomp $exception;
    warn "Error: $exception\n";
    # The /x mode means you need to specify spaces.
    if ($exception =~ /Can't\s+read\s+GLOB/xms) {
      warn "Can\'t convert to CSV. Were contents entered?\n";
    }
    exit $ERROR;    #return -1;
  }
  # Success
  else {
    $return_val = print "\nDone\n\n";
    #`$output_path`;    # Open output file.

    # If EXPR is omitted, exits with 0 status. The only universally
    # recognized values for EXPR are 0 for success and 1 for error; other
    # values are subject to interpretation depending on the environment in
    # which the Perl program is running.
    exit $SUCCESS;    # Return a value or any other information? #return 0;
    # Possibly close files if they are open.
  }
} # End run


#############################################################################
# Usage: main(@ARGV);
# Purpose: Executes main program logic. Reads one or more input files, or
#          STDIN, do some processing, and output results to an output file,
#          or STDOUT.
# Returns: 0 (SUCCESS)
# Parameters: @ARGV
# Throws: "Cannot open $output_path: $ERRNO\n"
#         "Cannot close $output_path: $ERRNO\n"
# Comments: This is the main body of the program.
sub main {
  my (@ARGV) = @_;
  # $ARGV{} is not the same as @ARGV.
  if ($ARGV{'-v'}) { warn "procedure main @ARGV\n"; }

  # Default variables
  # Note: This directory needs to change if the script is used on another
  # computer.
  my $input_dir   = 'C:\\Users\\machine_user\\';
  my $output_dir  = $input_dir;
  my $input_path  = q{};  # $input_dir . 'input.txt';
  my $output_path = q{}; # $output_dir . 'output.txt';

  # Accept input from a pipe and redirection if appropriate.

  # Note: Using is_interactive() instead of -t allows t/perlcritic.t to pass.
  # A terminal is normal processing.
  # my $stdin_is_a_teletype = (-t STDIN);
  # A pipe sends a file path argument or content to STDIN.
  my $stdin_is_a_pipe    = (-p STDIN);
  # Redirected input sends the file contents to STDIN.
  # It is neither a teletype nor a pipe.
  # my $stdin_is_redirected   = (!$stdin_is_a_teletype) && (!$stdin_is_a_pipe);
  # A terminal is normal processing.
  # my $stdout_is_a_teletype = (-t STDOUT);
  # A pipe sends a file path argument to STDIN.
  my $stdout_is_a_pipe    = (-p STDOUT);  # Ex. MyModulino.pl -v | sort
  # Redirected input sends the file contents to STDIN.
  # my $stdout_is_redirected=(!$stdout_is_a_teletype) && (!$stdout_is_a_pipe);
  if ($ARGV{'-v'}) { # warn "-t: $stdin_is_a_teletype -p:$stdin_is_a_pipe "
    # ." redirected_input: $stdin_is_redirected\n";
    # warn "-t: $stdout_is_a_teletype -p: $stdout_is_a_pipe "
    # ." redirected_output: $stdout_is_redirected\n";
    # Note: Without the argument, this does not appear to be correct on
    # MyModulino -v > output.txt. is_interactive(*STDERR)
    # This subroutine returns true if *ARGV and the currently selected
    # filehandle (usually *STDOUT) are connected to the terminal.
    # You can also pass is_interactive a writable filehandle, in which case
    # it requires that filehandle be connected to a terminal (instead of the
    # currently selected).
    warn "stdin_is_a_pipe: $stdin_is_a_pipe stdout_is_a_pipe: $stdout_is_a_pipe\n";
    warn 'is_interactive: ' . is_interactive() . "\n";
    warn 'is_interactive(*STDERR): ' . is_interactive(*STDERR) . "\n";
    warn 'is_interactive(*STDOUT): ' . is_interactive(*STDOUT) . "\n";
  }

  # NOT INTERACTIVE
  # Redirection from STDIN is not interactive
  # Pipe is not interactive as a line of input files or type contents.
  # Redirection to a file is not interactive on STDIN

  # INTERACTIVE
  # No input file, no redirection, no pipe is interactive on all FILEHANDLES.
  # Redirection to a file is interactive on STDERR.
  # Pipe from the program is interactive on STDERR.

  if ($stdin_is_a_pipe) {
    my $status = process_piped_input({ stdin_is_a_pipe=>$stdin_is_a_pipe,
      stdout_is_a_pipe=>$stdout_is_a_pipe, input_dir=>$input_dir,
      file_handle_ref=>\*ARGV
    });
  }

  # Getopt::Euclid fills the %ARGV hash with chosen command line options.
  # Use program arguments for input and output files if given.
  # Don't forget to use quotes on $ARGV{'argument'}; Barewords cause errors
  # on --.
  if ($ARGV{'-v'}) { my $str = _display_argv_hash(); }
  # Always allow - as a special filename.
  # A widely used convention is that a dash (-) where an input file is
  # expected means "read from standard input", and a dash where an output
  # file is expected means write to standard output.
  my $input_file_was_entered = defined $ARGV{'-i'} && $ARGV{'-i'} ne q{-};
  # my $input_file_is_default = defined $ARGV{'-i'} && $ARGV{'-i'} eq '-';
  #if ($input_file_was_entered) {
  #    $input_path = $ARGV{'-i'};
  #}
  my $input_files_were_entered_after_two_dashes = defined $ARGV{q{--}};
  # Input files can come from -i=file path or after -- on the command line.
  # Input files piped into the program can be added to -- storage.
  # If no input files were entered, read from STDIN by default
  # (no input files in '--' and input file = '-', which stands for STDIN).
  my $no_input_files_entered = ((!defined $ARGV{q{--}}) && ($ARGV{'-i'} eq q{-}));
  if ($ARGV{'-v'}) {
    warn '$no_input_files_entered ' . $no_input_files_entered . "\n";
    warn 'defined $ARGV{q{--}} ' . (defined $ARGV{q{--}}) . "\n";
    warn '!defined $ARGV{q{--}} ' . (!defined $ARGV{q{--}}). "\n";
    warn '$ARGV{\'-i\'} eq q{-} ' . ($ARGV{'-i'} eq q{-}) . "\n";
  }

  my $output_file_was_entered = defined $ARGV{'-o'} && $ARGV{'-o'} ne q{-};
  # my $output_file_is_default = defined $ARGV{'-o'} && $ARGV{'-o'} eq '-';
  if ($output_file_was_entered) {
      $output_path = $ARGV{'-o'};
  }

  my $nbr = _common_regexp();

  display_header($PROGRAM, @ARGV);

  # Process options entered by the user on the command line.
  process_command_line_options({ program=>$PROGRAM, version=>$VERSION,
    usage=>$USAGE, no_input_files_entered=>$no_input_files_entered,
    stdin_is_a_pipe=>$stdin_is_a_pipe
  });

  # Redirection gets the input from a file, so it doesn't need to be added
  # here.
  # is_interactive() # 1
  if ($no_input_files_entered && !$stdin_is_a_pipe) {
    # Get input from stdin and put that input into a flat file.
    # Read data from standard in into a flat file called copy_of_stdin.txt.
    # This is done so the input can read by $csv_format->read_file($input_fh).
    # I tried opening a variable reference. It didn't work on
    # $csv_format->read_file($input_fh).
    my $contents_entered = read_data_from_stdin_into_a_flat_file($input_dir,
      \*ARGV
    );
    if (!$contents_entered) {
      $return_val = print "Exiting program.\n";
      exit $SUCCESS;
    }
  }

  # Generate the list of files to process.
  my @input_file_paths = generate_unique_input_files_array({
    input_dir=>$input_dir, input_file_was_entered=>$input_file_was_entered,
    input_files_were_entered_after_two_dashes=>
    $input_files_were_entered_after_two_dashes,
    no_input_files_entered=>$no_input_files_entered
  });
  $return_val = print "Process unique list of input files: \n";
  foreach my $file_path (@input_file_paths) {
    $return_val = print "'$file_path' ";
  }
  $return_val = print "\n";

  # Don't open the output file if no output file was specified by the user.
  my $output_fh;
  if ($output_file_was_entered) {
    if ($ARGV{'-v'}) { warn "Open output file.\n"; }
    #unlink $output_fh or croak( "Cannot unlink $output_path: $!\n" );
    # open and clear output file
    open $output_fh,  '>:encoding(UTF-8)', $output_path
      or croak( "Cannot open $output_path: $ERRNO\n" ); # $!
    close $output_fh
      or croak( "Cannot close $output_path: $ERRNO\n" ); # $!
    # reopen output file to append to it
    open $output_fh,  '>>:encoding(UTF-8)', $output_path
      or croak( "Cannot open $output_path: $ERRNO\n" );
  }
  my $status = parse_csv_input_files_and_write_to_output({
    output_fh=>$output_fh, output_path=>$output_path,
    output_file_was_entered=>$output_file_was_entered,
    input_file_paths=>[@input_file_paths]
  });
  if ($output_file_was_entered) {
    close $output_fh or croak( "Cannot close $output_path: $ERRNO\n" );
  }
  return $SUCCESS;
} # End main


#############################################################################
# Usage: display_header($PROGRAM, @ARGV);
# Purpose: Displays the header and processes command line options.
# Returns: string with the header in it.
# Parameters: program name, arguments in @ARGV
# Throws: No exceptions
# Comments: The reference is most useful to pass more than three arguments.
sub display_header {
  my ($program, @ARGV) = @_;

  if ($ARGV{'-v'}) { warn 'procedure display_header '
    ."$program @ARGV\n";
  }

  # Readonly did not work with these strings.
  my $STRING        = q{-};
  my $STRING_LENGTH = 78;
  my $str           = ($STRING x $STRING_LENGTH) . "\n";
  $str             .= "$program\n";
  $str             .= ($STRING x $STRING_LENGTH) . "\n";
  $return_val       = print $str;

  $str             .= "Arguments: @ARGV\n";
  $return_val       = print "Arguments: @ARGV\n";

  return $str;
} # End display_header


#############################################################################
# Usage: process_piped_input({ stdin_is_a_pipe=>$stdin_is_a_pipe,
#     stdout_is_a_pipe=>$stdout_is_a_pipe, input_dir=>$input_dir,
#     file_handle_ref=>$file_handle_ref });
# Purpose: Handle piped input. Read that input using <ARGV> or <>.
# Returns: 0 Success
# Parameters: a hash reference containing named parameters:
# a boolean value indicating whether stdin is a pipe
# a boolean value indicating whether stdout is a pipe
# input directory
# file handle reference to a glob of the file handle
# Throws: "Cannot open $input_dir" . 'copy_of_stdin.txt'. ": $ERRNO\n"
#         "Cannot close $input_dir" . "copy_of_stdin.txt: $ERRNO\n"
# Comments: TODO: Receive input from a reference with arguments.
sub process_piped_input {
  my ($arg_ref) = @_;
  # Determine what to do with piped input.

  if ($ARGV{'-v'}) {
    warn "procedure process_piped_input\n";
    warn 'eof STDIN: \'' . eof(STDIN) . "'\n";
    warn "-p STDIN: $arg_ref->{'stdin_is_a_pipe'}\n";
    # warn "-t STDIN: $arg_ref->{'stdin_is_a_teletype'}\n";
    #warn 'eof STDOUT: \'' . eof(STDOUT) . "'\n";
    warn "-p STDOUT: $arg_ref->{'stdout_is_a_pipe'}\n";
    # warn "-t STDOUT: $arg_ref->{'stdout_is_a_teletype'}\n";
    # warn 'is_interactive: ' . is_interactive() . "\n";
    warn "file_handle_ref type: " . ref $arg_ref->{file_handle_ref};
  }

  die "Argument file_handle_ref in process_piped_input must be a reference "
    . "to a glob." if (ref $arg_ref->{file_handle_ref} ne 'GLOB');

  open my $stdin_fh,  '>', $arg_ref->{'input_dir'} . 'copy_of_stdin.txt'
    or croak( "Cannot open $arg_ref->{'input_dir'}" . 'copy_of_stdin.txt'
      . ": $ERRNO\n" );

  my $input_is_a_list_of_files = 1;
  # Dereference the reference into a glob. This means you must pass a
  # reference to a glob, like \*ARGV or \*$file_handle.
  # You have to dereference before reading the file handle.
  # You cannot dereference in <>.
  my $file_handle = *{ $arg_ref->{'file_handle_ref'} };

  GET_INPUT_FROM_PIPE:
  while (defined(my $input = <$file_handle>)) {
    if ($ARGV{'-v'}) {
      warn 'eof STDIN: \'' . eof(STDIN) . "'\n";
      warn "-p STDIN: $arg_ref->{'stdin_is_a_pipe'}\n";
      # warn "-t STDIN: $arg_ref->{'stdin_is_a_teletype'}\n";
      #warn 'eof STDOUT: \'' . eof(STDOUT) . "'\n";
      warn "-p STDOUT: $arg_ref->{'stdout_is_a_pipe'}\n";
      # warn "-t STDOUT: $arg_ref->{'stdout_is_a_teletype'}\n";
      # warn 'is_interactive: ' . is_interactive() . "\n";
      warn "String $INPUT_LINE_NUMBER: $input\n"; # $.
    }

    # Save the input into a flat file.
    # Text::CSV::Simple can only read from a flat file, not a string.
    $return_val = print {$stdin_fh} $input;

    my @file_paths = ();

    DETERMINE_IF_TEXT_IS_A_LIST_OF_FILES:
    while ($input_is_a_list_of_files
      && $input =~ m{
          ([^\s"']+)  # capture text without whitespace, ", or ' OR
          |"([^"]+)"  # text in double quotes--do not capture the " OR
          |'([^']+)'  # text in single quotes--do not capture the '
      }gxms
    ) {
      my $text_without_spaces_or_quotes = $1;
      my $double_quoted_text = $2;
      my $single_quoted_text = $3;
      my $match = q{};
      if (defined $text_without_spaces_or_quotes) {
        $match = $text_without_spaces_or_quotes;
        if ($ARGV{'-v'}) { $return_val = print 'Text without spaces: '
          . $match . "\n";
        }
      }
      elsif (defined $double_quoted_text) {
        $match = $double_quoted_text;
        if ($ARGV{'-v'}) { $return_val = print 'Text in double quotes: '
          . $match . "\n";
        }
      }
      elsif (defined $single_quoted_text) {
        $match = $single_quoted_text;
        if ($ARGV{'-v'}) { $return_val = print 'Text in single quotes: '
          . $match . "\n";
        }
      }
      # Determine if the input is a file.
      if (-e $match) {
        if ($ARGV{'-v'}) { $return_val = print "File exists: $match\n"; }
        push @file_paths, $match;
      }
      else
      {
        if ($ARGV{'-v'}){$return_val=print "File doesn't exist: $match\n";}
        # Quit searching for files on the first test that fails.
        # This likely means the input is file contents, not files.
        # This expects the first file to exist or there will be an error.
        $input_is_a_list_of_files = 0;
        last DETERMINE_IF_TEXT_IS_A_LIST_OF_FILES;
      }
    }

    # Read multiple files as a string from standard in.
    # TODO: This won't split correctly on file paths without quotes.
    # (?<=['\"]?\S+['\"]?)\s+(?=['\"]?\S+['\"]?)
    # [^\s"']+|"([^"]*)"|'([^']*)'
    # my @file_paths = split /['\"]{1}\s+['\"]{1}/xms, $input;
    #if ((scalar @file_paths) == 1) {
    #  @file_paths = split /\s+/, $input;
    #}
    #foreach my $file_path (@file_paths) {
    #  # This changes the file paths in @file_paths.
    #  $file_path =~ s/\s+[\f\n]+$//gxms;
    #  $file_path =~ s/(^['\"])|(['\"]$)//gxms;
    #}

    # Remove file paths which do not exist.
    #my @elements_to_remove = grep { !-e } @file_paths;
    #foreach my $element (@elements_to_remove) {
    #  if ($ARGV{'-v'}) { warn "$element does not exist.\n"; }
    #}
    #if ($ARGV{'-v'}) { warn "Remove elements which do not exist.\n"; }

    # Keep existing file paths.
    #@file_paths = grep { -e } @file_paths;
    #foreach my $element2 (@file_paths) {
    #  if ($ARGV{'-v'}) { warn "$element2 exists.\n"; }
    #}
    #if ($ARGV{'-v'}) { warn "Keep elements which exist.\n"; }

    my $count = scalar @file_paths;
    if ($ARGV{'-v'}) { warn "$count file_paths: @file_paths\n"; }

    # Save the values to the existing file paths array.
    if ($count > 0) { push @{ $ARGV{q{--}} }, @file_paths; }
    # if ($ARGV{'-v'}) { warn scalar @{ $ARGV{q{--}} }; }
    # Skip to the end on lines that are whitespace.
    last GET_INPUT_FROM_PIPE if $input !~ /\S/xms;
  }
  close $stdin_fh
    or croak( "Cannot close $arg_ref->{'input_dir'}" . 'copy_of_stdin.txt: '
      ."$ERRNO\n" );
  return $SUCCESS;
} # End process_piped_input


#############################################################################
# Usage: read_data_from_stdin_into_a_flat_file($input_dir, $file_handle_ref);
# Purpose: Read data into a flat file called "$input_dir"."copy_of_stdin.txt.
# Returns: 0 or 1 ($contents_entered)
# Parameters: input directory
#   a file handle reference to a glob of the file handle. This is done for
#   testing.
# Throws: "Cannot open $input_dir" . 'copy_of_stdin.txt'. ": $ERRNO\n"
#         "Cannot close $input_dir" . "copy_of_stdin.txt: $ERRNO\n"
# Comments: None
sub read_data_from_stdin_into_a_flat_file {
  my ($input_dir, $file_handle_ref) = @_;

  if ($ARGV{'-v'}) {
    warn "procedure read_data_from_stdin_into_a_flat_file $input_dir\n";
    warn 'Read input from STDIN by default, and write'
      . " it to a temporary file.\n";
    warn "file_handle_ref type: " . ref $file_handle_ref;
  }
  
  die "Second argument in read_data_from_stdin_into_a_flat_file must be a "
    . "reference to a glob." if (ref $file_handle_ref ne 'GLOB');
  
  open my $stdin_fh,  '>', $input_dir . 'copy_of_stdin.txt'
    or croak( "Cannot open $input_dir" . 'copy_of_stdin.txt'. ": $ERRNO\n" );
  my $contents_entered
    = get_data_from_user_and_print_to_input_file($stdin_fh,$file_handle_ref);
  close $stdin_fh
    or croak( "Cannot close $input_dir" . "copy_of_stdin.txt: $ERRNO\n" );

  if ($contents_entered) {
    $return_val = print "Wrote input to file: ${input_dir}copy_of_stdin.txt\n";
  }

  return $contents_entered;
} # End read_data_from_stdin_into_a_flat_file


#############################################################################
# Usage: get_data_from_user_and_print_to_input_file($stdin_fh,
#   $file_handle_ref);
# Purpose: Read data from standard in. Reading ends after an empty line.
#          Print input to an input file for further processing.
# Returns: 0 or 1 ($contents_entered)
# Parameters: standard in file handle
# Throws:
# Comments: None
sub get_data_from_user_and_print_to_input_file {
  my ($stdin_fh, $file_handle_ref) = @_;

  if ($ARGV{'-v'}) { warn 'procedure '
    ."get_data_from_user_and_print_to_input_file $stdin_fh "
    ."$file_handle_ref\n";
  }
  #if ($stdout_is_redirected) { warn 'STDOUT is redirected to a file'; }
  #if ($stdin_is_redirected) { warn 'STDIN is redirected from a file'; }
  # TODO: Display this message or not prompt on redirection in.
  my $str = 'Enter file contents to parse from CSV '
    . "(Hit enter once or twice to exit): \n";
  $str .= "EXAMPLE:\n";
  $str .= "field1, field2, field3\n";
  $str .= "first_name, last_name, year\n";
  $str .= "INPUT: ";
  # Display the above message for context when STDOUT is redirected.
  # There is no user input when STDIN is redirected.
  #if ($stdout_is_redirected && !$stdin_is_redirected) { warn $str; }
  # TODO: both need to run on output redirection MyModulino.pl > output.txt
  # is_interactive is false !is_interactive is true
  # This works when output is redirected.
  if (!is_interactive() && is_interactive(*STDERR)) {
    warn "$str\n";
  }
  $return_val = print "$str\n";

  my $contents_entered = 0;
  # Dereference the reference into a glob. This means you must pass a
  # reference to a glob, like \*ARGV or \*$file_handle.
  my $file_handle = *{ $file_handle_ref };

  INPUT:
  while (defined(my $line = <$file_handle>)) {
    # Type Ctrl + Z or Ctrl + D to end input
    chomp $line;
    # $line =~ /\S/xms or last INPUT;
    if ($line =~ /\S/xms) {
      # Display the input in the file which was redirected to.
      #if ($stdin_is_redirected || $stdout_is_redirected) { $return_val
      #  = print $line. "\n";
      #}
      # Display the lines in a file on output redirection and
      # to STDOUT on input redirection.
      if (!is_interactive()) { $return_val
        = print "$line\n";
      }
      $return_val = print {$stdin_fh} $line. "\n";
      $contents_entered = 1;
    }
    else {
      last INPUT;
    }
  }
  if (!$contents_entered) {
    $return_val = print "No contents entered.\n";
  }
  return $contents_entered;
} # End get_data_from_user_and_print_to_input_file


#############################################################################
# Usage: process_command_line_options({ program=>$PROGRAM, version=>$VERSION,
#    usage=>$USAGE, no_input_files_entered=>$no_input_files_entered,
#    stdin_is_a_pipe=>$stdin_is_a_pipe
# });
# Purpose: Executes command line options.
# Returns: a reference to a hash of arguments
# Parameters: a hash reference containing named parameters:
#            program name, version number, usage as a string, a boolean
#            representing whether input files were entered, a boolean
#            representing whether STDIN is a pipe
# Throws: No exceptions
# Comments: None
# TODO: replace arguments with named arguments in a hash reference.
sub process_command_line_options {
  my ($arg_ref) = @_;
  # if ($ARGV{'-v'}) { #warn "procedure process_command_line_options $program, "
    # ."$version, $usage, $no_input_files_entered, $stdin_is_redirected, "
    #."$stdout_is_redirected";
  # }
  if ($ARGV{'-v'}) { warn "procedure process_command_line_options\n"; }

  # Getopt::Euclid has parsed commandline parameters and stored them in %ARGV

  # Continue processing except for --help, --man, --usage, and --version,
  # which exit.

  # Input and output file arguments

  # $ARGV{'-infile'}
  if ($ARGV{'-i'}) {
    display_input_file_argument($ARGV{'-i'},
      $arg_ref->{'no_input_files_entered'}, $arg_ref->{'stdin_is_a_pipe'}
    );
  }
  # $ARGV{'-outfile'}
  if ($ARGV{'-o'}) {
    display_output_file_argument($ARGV{'-o'});
  }

  # Verbose

  if ($ARGV{'-v'}) {
    display_verbose_argument($ARGV{'-v'});  # $ARGV{'-verbose'}
  }

  # Note: Getopt::Euclid can make it's own content in the output for --help,
  # --man, --usage, and --version. Don't forget the quotes around the
  # argument in $ARGV{}. Otherwise, -- in front of the variable will cause
  # an error.

  # Standard arguments

  if ($ARGV{'--help'} || $ARGV{q{/?}} || $ARGV{'-help'} || $ARGV{'-h'}) {
    # print Getopt::Euclid::help();    # Displays help in POD format.
    # Displays Getopt::Euclid message in plain text.
    # Getopt::Euclid::_print_pod( Getopt::Euclid::help(), 'paged' );
    display_help($arg_ref->{'program'}, $arg_ref->{'usage'});
    exit $SUCCESS;
  }
  if ($ARGV{'--man'}) {
    # print Getopt::Euclid::man();     # Displays man in POD format.
    # Displays Getopt::Euclid message in plain text.
    # Getopt::Euclid::_print_pod( Getopt::Euclid::man(), 'paged' );
    display_manual($arg_ref->{'program'});
    exit $SUCCESS;
  }
  if ($ARGV{'--usage'}) {
    # print Getopt::Euclid::usage();   # Displays usage in POD format.
    # Displays Getopt::Euclid message in plain text.
    # Getopt::Euclid::_print_pod( Getopt::Euclid::usage(), 'paged' );
    display_usage($arg_ref->{'usage'});
    exit $SUCCESS;
  }
  if ($ARGV{'--version'}) {
    # print Getopt::Euclid::version(); # Displays version in POD format.
    # Displays Getopt::Euclid message in plain text.
    # Getopt::Euclid::_print_pod( Getopt::Euclid::version(), 'paged' );
    display_version($arg_ref->{'version'});
    exit $SUCCESS;
  }

  # Multiple input files after -- on commandline.

  if ($ARGV{q{--}}) {
    $return_val = print "Read in a list of input files after -- or from a pipe:\n";
    display_input_file_arguments($ARGV{q{--}});
  }
  # TODO: This does not work. I can't access the hash elements.
  return \%ARGV;
} # End process_command_line_options


#############################################################################
# Usage: generate_unique_input_files_array({
#    input_dir=>$input_dir,
#    input_file_was_entered=>$input_file_was_entered,
#    input_files_were_entered_after_two_dashes=>
#    $input_files_were_entered_after_two_dashes,
#    no_input_files_entered=>$no_input_files_entered
# });
# Purpose: Generate a unique list of input files based on command line
#   arguments.
# Returns: unique list of input files
# Parameters: a hash reference containing named parameters:
#   the input directory, and a boolean value called no input files
#   entered, a boolean value indicating whether input files were entered,
#   a boolean indicating whether no input files were entered
# Throws: No exceptions
# Comments: This subroutine does not use $input_path.
sub generate_unique_input_files_array {
  my ($arg_ref)=@_;
  if ($ARGV{'-v'}) { warn 'procedure generate_unique_input_files_array '
    . "$arg_ref->{'input_dir'}, '$arg_ref->{'input_file_was_entered'}', "
    . "'$arg_ref->{'input_files_were_entered_after_two_dashes'}', "
    . "'$arg_ref->{'no_input_files_entered'}'\n";
    warn "Add appropriate input files to an input_files array.\n";
    warn "input directory: $arg_ref->{'input_dir'}\n";
    warn "no input files entered: $arg_ref->{'no_input_files_entered'}\n";
  }

  my @input_file_paths = ();
  # If files exist after the marker --, add them to an array.
  if ($arg_ref->{'input_files_were_entered_after_two_dashes'}) {
    if ($ARGV{'-v'}) { warn "input_files_were_entered_after_two_dashes\n"; }
    # Change case to lowercase to avoid duplicates with different case.
    # Use map instead of for when generating new lists from old.
    @input_file_paths = map { lc } @{ $ARGV{q{--}} };
    #foreach my $file_path (@{ $ARGV{q{--}} }) {
    #  # This changes the file paths in @{ $ARGV{q{--}} }.
    #  $file_path = lc $file_path;
    #}
    #push @input_file_paths, @{ $ARGV{q{--}} };
  }
  # If -i is not equal to '-' (which is default), add it to an array.
  if ($arg_ref->{'input_file_was_entered'}) {
    if ($ARGV{'-v'}) { warn "input_file_was_entered\n"; }
    push @input_file_paths, lc $ARGV{'-i'};
  }
  # If no files exist after the marker --, and -i equals -, add a
  # temporary file to the array which holds contents from stdin.
  if ($arg_ref->{'no_input_files_entered'}) {
    if ($ARGV{'-v'}) { warn "no_input_files_entered\n"; }
    push @input_file_paths, lc ($arg_ref->{'input_dir'}.'copy_of_stdin.txt');
  }

  return wantarray ? uniq sort @input_file_paths : scalar @input_file_paths;
} # End generate_unique_input_files_array


#############################################################################
# Usage: process_line($line_ref);
# Purpose: Return pertinant information from the line reference
# Returns: A reference to the pertinant information on a line.
# Parameters: line reference
# Throws: No exceptions
# Comments:
sub process_line {
  my ($line_ref) = @_;
  #chomp $line;    # remove newline character
  if ($ARGV{'-v'}) {
    warn "procedure process_line\n";
    #warn "$line_ref->{field1} $line_ref->{field2} $line_ref->{field3}\n";
    #warn "$line_ref->{'Symbol'} $line_ref->{'Company Name'} $line_ref->{'Last Price'} $line_ref->{'Change'} $line_ref->{'% Change'} $line_ref->{'Volume'}\n";
  }

  #return {
  #  field1 => (defined $line_ref->{field1}) ? $line_ref->{field1} : q{},
  #  field2 => (defined $line_ref->{field2}) ? $line_ref->{field2} : q{},
  #  field3 => (defined $line_ref->{field3}) ? $line_ref->{field3} : q{},
  #};
  
  #return {
  #  'Symbol'       => (defined $line_ref->{'Symbol'})       ? $line_ref->{'Symbol'}       : q{},
  #  'Company Name' => (defined $line_ref->{'Company Name'}) ? $line_ref->{'Company Name'} : q{},
  #  'Last Price'   => (defined $line_ref->{'Last Price'})   ? $line_ref->{'Last Price'}   : q{},
  #  'Change'       => (defined $line_ref->{'Change'})       ? $line_ref->{'Change'}       : q{},
  #  '% Change'     => (defined $line_ref->{'% Change'})     ? $line_ref->{'% Change'}     : q{},
  #  'Volume'       => (defined $line_ref->{'Volume'})       ? $line_ref->{'Volume'}       : q{},
  #};
  
  return {
    'Date'        => (defined $line_ref->{'Date'})        ? $line_ref->{'Date'}        : q{},
    'Open'        => (defined $line_ref->{'Open'})        ? $line_ref->{'Open'}        : q{},
    'High'        => (defined $line_ref->{'High'})        ? $line_ref->{'High'}        : q{},
    'Low'         => (defined $line_ref->{'Low'})         ? $line_ref->{'Low'}         : q{},
    'Close*'      => (defined $line_ref->{'Close*'})      ? $line_ref->{'Close*'}      : q{},
    'Adj Close**' => (defined $line_ref->{'Adj Close**'}) ? $line_ref->{'Adj Close**'} : q{},
    'Volume'      => (defined $line_ref->{'Volume'})      ? $line_ref->{'Volume'}      : q{}
  };
} # End process_line


#############################################################################
# Usage: parse_csv_input_files_and_write_to_output({
#     output_fh=>$output_fh, output_path=>$output_path,
#     output_file_was_entered=>$output_file_was_entered,
#     input_file_paths=>[@input_file_paths]
# });
# Purpose: Parse every CSV input file and write it to an output file if
#          appropriate.
# Returns: $SUCCESS
# Parameters: a hash reference containing named parameters:
#             output file handle, output path, boolean value indicating
#             output file was entered, array of input file paths
# Throws: None
# Comments: None
sub parse_csv_input_files_and_write_to_output {
  my ($arg_ref) = @_;
  if ($ARGV{'-v'}) {
    warn 'procedure parse_csv_input_files_and_write_to_output '
      ."$arg_ref->{'output_fh'}, $arg_ref->{'output_path'}, "
      ."$arg_ref->{'output_file_was_entered'}, "
      ."@{$arg_ref->{'input_file_paths'}}\n";
  }
  foreach my $file_path (@{$arg_ref->{'input_file_paths'}}) {
    $return_val = print "Process input file: $file_path\n";
    my @lines = parse_lines_in_csv_input_file($file_path);
    my $hash_ref = {
      output_fh=>$arg_ref->{'output_fh'},
      output_path=>$arg_ref->{'output_path'},
      output_file_was_entered=>$arg_ref->{'output_file_was_entered'},
      # TODO: Consider whether you should use lines=>\@lines instead.
      lines=>[@lines]
    };
    # _memory($hash_ref);
    if ($ARGV{'-v'}) { _print_data_dumper($hash_ref); }
    write_or_display_results($hash_ref);
  }
  return $SUCCESS;
} # End parse_csv_input_files_and_write_to_output


#############################################################################
# Usage: parse_lines_in_csv_input_file($input_path);
# Purpose: Get back usable information from the input file and put it in an
#          array.
# Returns: Array of transformed lines.
# Parameters: input file path
# Throws: "Cannot open $input_path: $ERRNO\n"
#         "Cannot close $input_path: $ERRNO\n"
# Comments: None
sub parse_lines_in_csv_input_file {
  my ($input_path) = @_;

  if ($ARGV{'-v'}) {
    warn "procedure parse_lines_in_csv_input_file\n";
    warn "Reading input file: $input_path.\n";
    warn "Instantiating new CSV format.\n";
  }
  # Specify the CSV format as defined in Text::CSV_XS.
  my $csv_format = Text::CSV::Simple->new({
    # The char used to separate fields, by default a comma. (,). Limited to a
    # single-byte character, usually in the range from 0x20 (space) to 0x7E
    # (tilde). When longer sequences are required, use sep. The separation
    # character can not be equal to the quote character or to the escape
    # character.
    sep_char    => ',',    # Comma delimited
    # The character to escape certain characters inside quoted fields. This
    # is limited to a single-byte character, usually in the range from 0x20
    # (space) to 0x7E (tilde). The escape_char defaults to being the
    # double-quote mark ("). In other words the same as the default
    # quote_char. This means that doubling the quote mark in a field escapes
    # it:
    escape_char => '\\',   # Backslashes are escape characters
    # The character to quote fields containing blanks or binary data, by
    # default the double quote character ("). A value of undef suppresses
    # quote chars (for simple cases only). Limited to a single-byte
    # character, usually in the range from 0x20 (space) to 0x7E (tilde). When
    # longer sequences are required, use quote. quote_char can not be equal
    # to sep_char.
    quote_char  => '"',    # Optional double quote around fields
    # When this option is set to true, the whitespace (TAB's and SPACE's)
    # surrounding the separation character is removed when parsing. If either
    # TAB or SPACE is one of the three characters sep_char, quote_char, or
    # escape_char it will not be considered whitespace. Note that all
    # whitespace is stripped from both start and end of each field.
    allow_whitespace => 1, # Allow whitespace after comma
    auto_diag        => 1,
    binary           => 1,
  });

  if ($ARGV{'-v'}) { warn "Map fields to CSV format.\n"; }
  #$csv_format->field_map( qw( field1 field2 field3 ) );
  #$csv_format->field_map( "Symbol","Company Name","Last Price","Change","% Change","Volume" );
  $csv_format->field_map( "Date","Open","High","Low","Close*","Adj Close**","Volume" );
  # for every line in the input file.
  # while ( my $line = <$input_fh> )
  # my @lines;
  if ($ARGV{'-v'}) {warn "Read file with CSV format object: $input_path.\n";}
  # open input file , 
  open my $input_fh, '<:encoding(UTF-8)', $input_path
    or croak( "Cannot open $input_path: $ERRNO\n" ); # $!
  # Parse CSV file
  # foreach my $line_ref ( $csv_format->read_file($input_fh) ) {
  #   push @lines, process_line($line_ref);
  #}
  my @lines = map { process_line($_) } $csv_format->read_file($input_fh);
  close $input_fh  or croak( "Cannot close $input_path: $ERRNO\n" ); # $!

  return wantarray ? @lines : scalar @lines;
} # End parse_lines_in_csv_input_file


#############################################################################
# Usage: write_or_display_results({
#      output_fh               => $output_fh,
#      output_path             => $output_path,
#      output_file_was_entered => $output_file_was_entered,
#      lines                   => [@lines]
#    });
# Purpose: save or display the results according to what the user entered.
# Returns: Success status
# Parameters: A reference to a hash with named parameters as input.
#   open output file handle, output path, boolean value stating whether
#   output_file_was_entered at command line, reference to an array of lines
#   to do something with
# Throws: "Cannot print to file $arg_ref->{'output_path'}: $ERRNO\n"
#         "Cannot print to file $arg_ref->{'output_path'}: $ERRNO\n"
# Comments: The reference is most useful to pass more than three arguments.
#           The downside is you have to have references to lists and hashes.
#           You can't use just a list or hash itself.
sub write_or_display_results {
  my ($arg_ref) = @_;

  if ($ARGV{'-v'}) { warn "procedure write_or_display_results\n"; }
  #if ($arg_ref->{'output_file_was_entered'}) {
  #if ($ARGV{'-v'}) {
  #  warn "'$arg_ref->{'output_fh'}' "
  #    . "'$arg_ref->{'output_path'}' "
  #    . "'$arg_ref->{'output_file_was_entered'}' "
  #    . "'@{$arg_ref->{'lines'}}'\n";
  #}

  # Loop through saved records
  if ($ARGV{'-v'}) { warn "Loop through saved records.\n"; }
  if ($arg_ref->{'output_file_was_entered'}) {
    $return_val = print "Write to output file: $arg_ref->{'output_path'}\n";
  }
  # Field types
  #     The format strings passed to "form" determine what the resulting
  #     formatted text looks like. Each format consists of a series of field
  #     specifiers, which are usually separated by literal characters.
  # 
  #     "form" understands a far larger number of field specifiers than "format"
  #     did, designed around a small number of conventions:
  # 
  #     *   Each field is enclosed in a pair of braces.
  # 
  #     *   Within the braces, left or right angle brackets ("<" or ">"), bars
  #         ("|"), and single-quotes ("'") indicate various types of single-line
  #         fields.
  # 
  #     *   Left or right square brackets ("[" or "]"), I's ("I"), and double-
  #         quotes (""") indicate block fields of various types.
  # 
  #     *   The direction of the brackets within a field indicates the direction
  #         towards which text will be justified in that field. For example:
  # 
  #             {<<<<<<<<<<<}   Justify the text to the left
  #             {>>>>>>>>>>>}                  Justify the text to the right
  #             {>>>>>><<<<<}                 Centre the text
  #             {<<<<<<>>>>>}   Fully  justify  the  text  to  both  margins
  # 
  #         This is even true for numeric fields, which look like: "{>>>>>.<<}".
  #         The whole digits are right-justified before the dot and the decimals
  #         are left-justified after it.
  # 
  #     *   An "=" at either end of a field (or both ends) indicates the data
  #         interpolated into the field is to be vertically "middled" within the
  #         resulting block. That is, the text is to be centred vertically on
  #         the middle of all the lines produced by the complete format.
  # 
  #     *   An "_" at the start and/or end of a field indicates the interpolated
  #         data is to be vertically "bottomed" within the resulting block. That
  #         is, the text is to be pushed to the bottom of the lines produced by
  #         the format.
  # 
  #     For example:
  # 
  #                                           Field specifier
  #         Field type                 One-line             Block
  #         ==========                ==========          ==========
  # 
  #         left justified            {<<<<<<<<}          {[[[[[[[[}
  #         right justified           {>>>>>>>>}          {]]]]]]]]}
  #         centred                   {>>>><<<<}          {]]]][[[[}
  #         centred (alternative)     {||||||||}          {IIIIIIII}
  #         fully justified           {<<<<>>>>}          {[[[[]]]]}
  #         verbatim                  {''''''''}          {""""""""}
  # 
  #         numeric                   {>>>>>.<<}          {]]]]].[[}
  #         euronumeric               {>>>>>,<<}          {]]]]],[[}
  #         comma'd                   {>,>>>,>>>.<<}      {],]]],]]].[[}
  #         space'd                   {> >>> >>>.<<}      {] ]]] ]]].[[}
  #         eurocomma'd               {>.>>>.>>>,<<}      {].]]].]]],[[}
  #         Swiss Army comma'd        {>'>>>'>>>,<<}      {]']]]']]],[[}
  #         subcontinental            {>>,>>,>>>.<<}      {]],]],]]].[[}
  # 
  #         signed numeric            {->>>.<<<}          {-]]].[[[}
  #         post-signed numeric       {>>>>.<<-}          {]]]].[[-}
  #         paren-signed numeric      {(>>>.<<)}          {(]]].[[)}
  # 
  #         prefix currency           {$>>>.<<<}          {$]]].[[[}
  #         postfix currency          {>>>.<<<DM}         {]]].[[[DM}
  #         infix currency            {>>>$<< Esc}        {]]]$[[ Esc}
  # 
  #         left/middled              {=<<<<<<=}          {=[[[[[[=}
  #         right/middled             {=>>>>>>=}          {=]]]]]]=}
  #         infix currency/middled    {=>>$<< Esc}        {=]]$[[ Esc}
  #         eurocomma'd/middled       {>.>>>.>>>,<<=}     {].]]].]]],[[=}
  #         etc.
  # 
  #         left/bottomed             {_<<<<<<_}          {_[[[[[[_}
  #         right/bottomed            {_>>>>>>_}          {_]]]]]]_}
  #         etc.
  use Perl6::Form;
  $return_val = print "Stocks:\n";
  #$return_val = print "Symbol Company Name                              "
  #  ."       Last Price   Change  % Change        Volume\n";
  #$return_val = print "-------------------------------------------------"
  #  ."--------------------------------------------------\n";
  $return_val = print "Date               Open        High        Low         Close*      Adj Close** Volume\n";
  $return_val = print "--------------------------------------------------------------------------------------------\n";
  binmode STDOUT, ':encoding(UTF-8)';
  #foreach my $line_ref ( sort {$a->{'Symbol'} cmp $b->{'Symbol'}} @{$arg_ref->{'lines'}} ) { 
  
  RESULTS:
  # $a->{'Symbol'} cmp $b->{'Symbol'} or $a->{'Change'} <=> $b->{'Change'}
  foreach my $line_ref ( sort _by_date_desc @{$arg_ref->{'lines'}} ) {
    
    # Skip the display. Go to the output file.
    if ($line_ref->{'Date'} eq 'Date') { goto OUTPUT_FILE; }
    
    DISPLAY:
    #my $str="$line_ref->{field1} $line_ref->{field2} $line_ref->{field3}\n";
    #my $str = form(
    #  '{>>>>} {[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[} '
    # .'{>>>,>>>,>>>.<<} {>>>>>} {>>>>>>>} {>>>>>>>>>>>}', 
    #  $line_ref->{'Symbol'}, $line_ref->{'Company Name'}, 
    #  $line_ref->{'Last Price'}, $line_ref->{'Change'}, 
    #  $line_ref->{'% Change'}, $line_ref->{'Volume'},
    #);
    my $str = form(
      '{>>>>>>>>>>>>>>>>} {>>>>>>>>>} {>>>>>>>>>} {>>>>>>>>>} {>>>>>>>>>} '
     .'{>>>>>>>>>} {>>>>>>>>>>>}',
      $line_ref->{'Date'},$line_ref->{'Open'},$line_ref->{'High'},
      $line_ref->{'Low'},$line_ref->{'Close*'},$line_ref->{'Adj Close**'},
      $line_ref->{'Volume'}
    );
    # Print to stout.
    
    $return_val = print $str;
    
    OUTPUT_FILE:
    # Print to output file if there is one.
    if ($arg_ref->{'output_file_was_entered'}) {
      #$str=qq{"$line_ref->{'Symbol'}","$line_ref->{'Company Name'}",}
      #   . qq{"$line_ref->{'Last Price'}","$line_ref->{'Change'}",}
      #   . qq{"$line_ref->{'% Change'}","$line_ref->{'Volume'}"\n};
      $str = qq{"$line_ref->{'Date'}","$line_ref->{'Open'}",}
           . qq{"$line_ref->{'High'}","$line_ref->{'Low'}",}
           . qq{"$line_ref->{'Close*'}","$line_ref->{'Adj Close**'}",}
           . qq{"$line_ref->{'Volume'}"\n};
      $return_val = print {$arg_ref->{'output_fh'}} $str
        or croak("Cannot print to file $arg_ref->{'output_path'}: $ERRNO\n");
    }
  }
  $return_val = print "\n";
  if ($arg_ref->{'output_file_was_entered'}) {
    $return_val = print {$arg_ref->{'output_fh'}} "\n"
      or croak("Cannot print to file $arg_ref->{'output_path'}: $ERRNO\n");
  }
  return $SUCCESS;
} # End write_or_display_results


#############################################################################
# Usage: by_date_desc();
# Purpose: sort lists
# Returns: sort operation
# Parameters: None
# Throws: No exceptions
# Comments: None
sub _by_date_desc { return $b->{'Date'} cmp $a->{'Date'}; }


#############################################################################
# Usage: display_help($program, $usage);
# Purpose: Display command line help for users.
# Returns: String containing help (--help) text. Note: this is the custom one
#          I made, not the one from Getopt::Euclid.
# Parameters: program path, command line syntax for this program.
# Throws: No exceptions
# Comments: None
sub display_help {
  my ($program, $usage) = @_;
  if ($ARGV{'-v'}) { warn "procedure display_help $program, $usage\n"; }

  my $str = "help:\n";
  $str .= "usage: $usage\n";
  #print "help: Type \"perldoc $program\" or \"perldoc Getopt::Euclid\" at "
  #    . "the command line for additional help.\n";
  $str .= "'perl MyModulino.pl -i=C:\\Users\\machine_user\\input.txt' accepts an input file\n";
  $str .= "'                   -i = C:\\Users\\machine_user\\input.txt'\n";
  $str .= "'                   -iC:\\Users\\machine_user\\input.txt'\n";
  $str .= "'                   -i C:\\Users\\machine_user\\input.txt'\n\n";
  $str .= "'                   -infile=C:\\Users\\machine_user\\input.txt'\n";
  $str .= "'                   -infile = C:\\Users\\machine_user\\input.txt'\n";
  $str .= "'                   -infileC:\\Users\\machine_user\\input.txt'\n";
  $str .= "'                   -infile C:\\Users\\machine_user\\input.txt'\n\n";
  $str .= "'perl MyModulino.pl -o=C:\\Users\\user_machine\\output.txt' accepts an output file\n";
  $str .= "'                   -o = C:\\Users\\machine_user\\output.txt'\n";
  $str .= "'                   -oC:\\Users\\machine_user\\output.txt'\n";
  $str .= "'                   -o C:\\Users\\machine_user\\output.txt'\n\n";
  $str .= "'                   -outfile=C:\\Users\\user_machine\\output.txt'\n";
  $str .= "'                   -outfile = C:\\Users\\machine_user\\output.txt'\n";
  $str .= "'                   -outfileC:\\Users\\machine_user\\output.txt'\n";
  $str .= "'                   -outfile C:\\Users\\machine_user\\output.txt'\n\n";

  $str .= "'perl MyModulino.pl -v' displays verbose output\n";
  $str .= "'                   -verbose'\n\n";

  $str .= "'perl MyModulino.pl --help' displays the usage and help on each command and exits\n\n";
  $str .= "'perl MyModulino.pl --man' displays the program manual and exits (similar to the Unix man command)\n\n";
  $str .= "'perl MyModulino.pl --usage' display program usage and exits (command line syntax)\n\n";
  $str .= "'perl MyModulino.pl --version' displays program version and exits\n\n";
  $str .= "'perl MyModulino.pl /?' displays the usage and help on each command and exits\n\n";
  $str .= "\nDone\n\n";
  $return_val = print $str;
  return $str;
} # End display_help


#############################################################################
# Usage: display_input_file_argument($input_file_argument,
#          $no_input_files_entered, $stdin_is_a_pipe
#        );
# Purpose: display the input file argument.
# Returns: String containing input file argument (-i) value.
# Parameters: input file argument, boolean no input files entered, boolean
#             STDIN is a pipe
# Throws: No exceptions
# Comments: None
sub display_input_file_argument {
  my ($input_file_argument, $no_input_files_entered, $stdin_is_a_pipe) = @_;
  if ($ARGV{'-v'}) { warn 'procedure '
    ."display_input_file_argument $input_file_argument "
    ."$no_input_files_entered $stdin_is_a_pipe\n";
  }

  my $str = "input file: $input_file_argument";
  # if ($input_file_argument eq q{-}) {
  if ($no_input_files_entered) { $str .= ' STDIN'; }
  if ($stdin_is_a_pipe) { $str .= ' STDIN receives input from a pipe'; }
  # if ($stdin_is_redirected) { $str .= ' STDIN is redirected from a file'; }
  $str .= "\n";
  $return_val = print $str;
  return $str;
} # End display_input_file_argument


#############################################################################
# Usage: display_input_file_arguments($ARGV{q{--}});
# Purpose: display a list of input file arguments.
# Returns: String containing a list of input file arguments (--).
# Parameters: a reference to a list of input file arguments
# Throws: No exceptions
# Comments: None
sub display_input_file_arguments {
  my ($array_of_input_files_ref) = @_;
  if ($ARGV{'-v'}) { warn 'procedure '
    ."display_input_file_arguments @{ $array_of_input_files_ref }\n";
  }

  my $str = 'Input files after -- or from a pipe: ';
  $return_val = print 'Input files after -- or from a pipe: ';
  foreach my $file_path (@{ $array_of_input_files_ref }) {
    $str .= "'$file_path' ";
    $return_val = print "'$file_path' ";
  }
  $str .= "\n";
  $return_val = print "\n";
  return $str;
} # End display_input_file_arguments


#############################################################################
# Usage: display_manual($program);
# Purpose: Display the windows equivalent of the unix man command (perldoc).
# Returns: String containing manual (--man) text.
# Parameters: program path of perldoc to run.
# Throws: No exceptions
# Comments: This procedure is slower than other subroutines. Note: this is
#           the custom one I made, not the one from Getopt::Euclid.
sub display_manual {
  my ($program) = @_;
  if ($ARGV{'-v'}) { warn "procedure display_manual $program\n"; }

  my $str = "man\n";
  $return_val = print "man\n";
  # Display full manual using perldoc.
  # Note: perldoc uses more functionality, so you don't have to implement it.
  my $input = `perldoc $program`;
  $str .= $input;
  $return_val = print $input;
  $str .= "\nDone\n\n";
  $return_val = print "\nDone\n\n";
  return $str;
} # End display_manual


#############################################################################
# Usage: display_output_file_argument($output_file_argument);
# Purpose: Display the output file argument entered at the command line.
# Returns: String containing output file argument (-o).
# Parameters: output file argument entered at the command line
# Throws: No exceptions
# Comments: None
sub display_output_file_argument {
  my ($output_file_argument) = @_;
  if ($ARGV{'-v'}) { warn 'procedure '
    ."display_output_file_argument $output_file_argument\n";
  }

  my $str = "output file: $output_file_argument";
  #if ($stdout_is_redirected) {
  #  warn "STDOUT is redirected to a file\n";
  #  $str .= ' STDOUT is redirected to a file';
  #}
  if ($output_file_argument eq q{-}) {
    $str .= ' STDOUT';
  }
  $str .= "\n";
  $return_val = print $str;

  return $str;
} # End display_output_file_argument


#############################################################################
# Usage: display_usage($usage);
# Purpose: Display the command line syntax to run the program.
# Returns: String containing usage (--usage) text.
# Parameters: Command line syntax as a string
# Throws: No exceptions
# Comments: Note: this is the custom one I made, not the one from
#           Getopt::Euclid.
sub display_usage {
  my ($usage) = @_;
  if ($ARGV{'-v'}) {warn "procedure display_usage $usage\n";}

  my $str = "usage: $usage\n";
  $return_val = print "usage: $usage\n";
  $str .= 'Any whitespace in the structure specifies that any amount of '
       .'whitespace (including none) is allowed at the same position on '
       .'the command-line.';
  $return_val = print 'Any whitespace in the structure specifies that any '
       .'amount of whitespace (including none) is allowed at the same '
       .'position on the command-line.';
  $str .= "\nDone\n\n";
  $return_val = print "\nDone\n\n";
  return $str;
} # End display_usage


#############################################################################
# Usage: display_verbose_argument($verbose_argument);
# Purpose: Displays verbose argument.
# Returns: String containing verbose argument (-v) value.
# Parameters: verbose argument
# Throws: No exceptions
# Comments: None
sub display_verbose_argument {
  my ($verbose_argument) = @_;
  if ($ARGV{'-v'}) { warn 'procedure '
    ."display_verbose_argument $verbose_argument\n";
  }

  my $str = "verbose $verbose_argument\n";
  $return_val = print $str;
  return $str;
} # End display_verbose_argument


#############################################################################
# Usage: display_version($version);
# Purpose: Displays program version.
# Returns: String containing version (--version) text.
# Parameters: version number
# Throws: No exceptions
# Comments: Note: this is the custom one I made, not the one from
#           Getopt::Euclid.
sub display_version {
  my ($version) = @_;
  if ($ARGV{'-v'}) { warn "procedure display_version $version\n"; }

  my $str = "version $version\n";
  $return_val = print "version $version\n";
  $str .= "\nDone\n\n";
  $return_val = print "\nDone\n\n";
  return $str;
} # End display_version


#############################################################################
# Usage: _common_regexp();
# Purpose: Try the library Regexp::Common.
# Returns: SUCCESS
# Parameters: None
# Throws: No exceptions
# Comments: For internal use only.
sub _common_regexp {
  my ($none) = @_;
  if ($ARGV{'-v'}) { warn "procedure _common_regexp\n"; }
  use Regexp::Common qw(Email::Address);
  use Email::Address;
  #   By default, this module exports a single hash (%RE) that stores or
  #   generates commonly needed regular expressions (see "List of available
  #   patterns").

  # List of available patterns
  #   The patterns listed below are currently available. Each set of patterns
  #   has its own manual page describing the details. For each pattern set
  #   named *name*, the manual page *Regexp::Common::name* describes the
  #   details.
  #
  #   Currently available are:
  #
  #   Regexp::Common::balanced
  #       Provides regexes for strings with balanced parenthesized delimiters.
  #
  #   Regexp::Common::comment
  #       Provides regexes for comments of various languages (43 languages
  #       currently).
  #
  #   Regexp::Common::delimited
  #       Provides regexes for delimited strings.
  #
  #   Regexp::Common::lingua
  #       Provides regexes for palindromes.
  #
  #   Regexp::Common::list
  #       Provides regexes for lists.
  #
  #   Regexp::Common::net
  #       Provides regexes for IPv4, IPv6, and MAC addresses.
  #
  #   Regexp::Common::number
  #       Provides regexes for numbers (integers and reals).
  #
  #   Regexp::Common::profanity
  #       Provides regexes for profanity.
  #
  #   Regexp::Common::whitespace
  #       Provides regexes for leading and trailing whitespace.
  #
  #   Regexp::Common::zip
  #       Provides regexes for zip codes.
  #
  # Forthcoming patterns and features
  #   Future releases of the module will also provide patterns for the
  #   following:
  #
  #           * email addresses                           Regexp::Common::Email::Address
  #           * HTML/XML tags
  #           * more numerical matchers,
  #           * mail headers (including multiline ones),
  #           * more URLS                                 Regexp::Common::URI  $RE{URI}
  #           * telephone numbers of various countries
  #           * currency (universal 3 letter format, Latin-1, currency names)
  #           * dates
  #           * binary formats (e.g. UUencoded, MIMEd)
  #                                                       Regexp::Common::CC  # Credit cards
  #                                                       Regexp::Common::time

  # my $str = "  		My string to trim 	\n"
  #        . "  		Second string to trim		\n";
  #my $str = "		  block		  \n";
  #print "BEFORE: '$str'\n";
  # Trims leading and trailing whitespace per line
  # Appears to delete newlines as well.
  # my $LEADING_AND_TRAILING_WHITESPACE_AND_NEWLINES = $RE{ws}{crop};
  #$str =~ s/$LEADING_AND_TRAILING_WHITESPACE_AND_NEWLINES//g;
  #print "AFTER: '$str'\n";

  #$RE{delimited}{-delim=>'"'}               # match "a \" delimited string"
  #$RE{delimited}{-delim=>'"'}{-esc=>'"'}    # match "a "" delimited string"
  #$RE{delimited}{-delim=>'/'}               # match /a \/ delimited string/
  #$RE{delimited}{-delim=>q{'"}}             # match "string" or 'string'
  #$RE{delimited}{-delim=>"("}{-cdelim=>")"} # match (string)

  #$RE{quoted}{-esc}
  #A synonym for "$RE {delimited} {-delim => q {'"`}} {...}".

  # my $str = "'This is a' quoted string.\n";
  # $return_val = print "Match quoted string: $str\n";
  # my $QUOTED_STRING = $RE{quoted}{-keep};
  # if ($str =~ /$QUOTED_STRING/) {
  #   my $string = $1;
  #   $return_val = print "Matches: $string\n";
  # }

  ## DOES NOT WORK with https://. Remove the https://.
  #my $str = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dstripbooks&field-keywords=Programming+Perl";
  ## my $str = "https://www.google.com/search?site=&source=hp&q=Perl+open+file+handle+to+STDOUT&oq=Perl+open+file+handle+to+STDOUT&gs_l=psy-ab.3..0i30k1.8934.23582.0.24830.55.43.10.0.0.0.160.4061.27j15.42.0....0...1.1.64.psy-ab..3.50.4046.0..0j0i131k1j0i3k1j0i22i30k1j0i13i30k1j0i8i13i30k1j0i7i30k1.VfmtOmcjuk4";
  #$str =~ s{^https://}{};
  #$return_val = print "Match domain name: $str\n";
  #my $DOMAIN = $RE{net}{domain}{-nospace}{-rfc1101}{-keep};
  #if ($str =~ /$DOMAIN/i) {
  #  my $string = $1;
  #  $return_val = print "Matches: $string\n";
  #}

  #my $str = "This is a string (with items in \n"
  #  ."parenthesis), and extra text.\n";
  #$return_val = print "Match parenthesis: $str\n";
  #my $TEXT_WITHIN_PARENTHESES_OR_BRACKETS = $RE{balanced}{-parens=>'()[]'}{-keep};
  #if ($str =~ /$TEXT_WITHIN_PARENTHESES_OR_BRACKETS/) {
  #  my $string = $1;
  #  $return_val = print "Matches: $string\n";
  #}

  #my $str = "This is a list: a,b,c.\n";
  #$return_val = print "Match a list: $str\n";
  ## {-lastsep=>',\s+and\s+'}{-lastsep=>'\s*,\s*'}
  ## $RE{list}{conj}
  #my $COMMA_SEPARATED_LIST = $RE{list}{-pat => '\w+'}{-sep => '\s*,\s*'}{-keep};
  #if ($str =~ /$COMMA_SEPARATED_LIST/) {
  #  my $string = $1;
  #$return_val = print "Match: $string\n";
  #}

  # file:///C:/Users/machine_user/Documents/Technical%20References/Perl/MyModulino.pl
  #my $str = "This is a url: http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dstripbooks&field-keywords=Programming+Perl\n"
  #  . 'This is additional text.';
  #$return_val = print "Match a uri: $str\n";
  # fax, file, FTP, gopher, HTTP, news, pop, prospero, tel, telnet, tv and WAIS.
  #my $URI = $RE{URI}{HTTP}{-scheme => 'https?'}{-keep};
  #if ($str =~ /$URI/xms) {
  #  my $string = $1;         # Entire string
  #  my $scheme = $2;         # The scheme
  #  my $host = $3;           # The host (name or address).
  #  my $port = $4;           # The port (if any).
  #  my $absolute_path1 = $5; # The absolute path, including the query and leading slash.
  #  my $absolute_path2 = $6; # The absolute path, including the query, without the leading slash.
  #  my $absolute_path3 = $7; # The absolute path, without the query or leading slash.
  #  my $query = $8;          # The query, without the question mark.
  #  $return_val = print "Match: $string\n";
  #  $return_val = print "Scheme: $scheme\n";
  #  $return_val = print "Host: $host\n";
  #  $return_val = print "Port: $port\n";
  #  # $return_val = print "Path with query and slash: $absolute_path3\n";
  #  $return_val = print "Path with query without slash: $absolute_path2\n";
  #  # $return_val = print "Path without query or slash: $absolute_path3\n";
  #  $return_val = print "Query without question mark: $query\n";
  #}
  #my $str = 'mausolf1@hotmail.com';
  #$return_val = print "Match an email address: $str\n";
  #my $EMAIL_ADDRESS = $RE{Email}{Address}{-keep};
  #if ($str =~ /$EMAIL_ADDRESS/xms) {
  #  #my $email_addr = $RE{ws}{crop}->subs($1);
  #  my $email_addr = $1;
  #  $return_val = print "Email address match: $email_addr\n";
  #}

  return $SUCCESS;
} # End _common_regexp


#############################################################################
# Usage: _compare($title);
# Purpose: Benchmark various subroutines.
# Returns: An array of arrays from the cmpthese Benchmark function.
# Parameters: title
# Throws: No exceptions
# Comments: For internal use only. Mildly useful.
# SPEED COMPARISON

# Winner on performance: lines=>\@lines is 2% faster
#our $hash_ref2 = {
#  output_fh=>$output_fh,
#  output_path=>$output_path,
#  output_file_was_entered=>$output_file_was_entered,
#  # TODO: Consider whether you should use lines=>\@lines instead.
#  lines=>\@lines
#};

#              Rate  hash_ref hash_ref2
# hash_ref  42687/s        --       -2%
# hash_ref2 43459/s        2%        --
#
# [write_or_display_results lines=>[@lines] versus lines=>\@lines]
# The code took: 72 wallclock secs ( 9.69 usr + 15.55 sys = 25.23 CPU)

# _compare('write_or_display_results lines=>[@lines] versus lines=>\@lines');
sub _compare {
  my ($title) = @_;
  if ($ARGV{'-v'}) { warn "procedure _compare\n"; }

  # This chart is sorted from slowest to fastest, and shows the
  # percent speed difference between each pair of tests.
  # ---------------------------------------
  # Example ran on 8/8/2017
  #             (warning: too few iterations for a reliable count)
  #                          Rate manual display_help version usage display_verbose process_command_line display_input_args display_input_arg display_output_arg
  # manual                  298/s     --         -95%    -99%  -99%           -100%                -100%              -100%             -100%              -100%
  # display_help           5556/s  1765%           --    -81%  -82%            -91%                 -92%               -93%              -94%               -96%
  # version               28791/s  9566%         418%      --   -7%            -55%                 -61%               -65%              -68%               -78%
  # usage                 30973/s 10298%         457%      8%    --            -51%                 -58%               -63%              -66%               -76%
  # display_verbose       63817/s 21324%        1049%    122%  106%              --                 -13%               -23%              -30%               -50%
  # process_command_line  73438/s 24554%        1222%    155%  137%             15%                   --               -12%              -19%               -43%
  # display_input_args    83182/s 27825%        1397%    189%  169%             30%                  13%                 --               -9%               -35%
  # display_input_arg     90918/s 30423%        1536%    216%  194%             42%                  24%                 9%                --               -29%
  # display_output_arg   128227/s 42948%        2208%    345%  314%            101%                  75%                54%               41%                 --
  #
  # [0.1 CPU SECONDS]
  # The code took: 80 wallclock secs ( 5.39 usr +  2.69 sys =  8.08 CPU)
  # ---------------------------------------
  # consider using timethese();
  use Benchmark qw( cmpthese timediff timestr timethese );

  my $t0 = Benchmark->new;

  # CPU seconds is, in UNIX terms, the user time plus the system
  # time of the process itself, as opposed to the real (wallclock)
  # time and the time spent by the child processes. Less than 0.1
  # seconds is not accepted (-0.01 as the count, for example, will
  # cause a fatal runtime exception).

  # Note that the CPU seconds is the minimum time: CPU scheduling
  # and other operating system factors may complicate the attempt
  # so that a little bit more time is spent. The benchmark output
  # will, however, also tell the number of $code runs/second,
  # which should be a more interesting number than the actually
  # spent seconds.

  # The COUNT can be zero or negative: this means the *minimum
  # number of CPU seconds* to run. A zero signifies the default of
  # 3 seconds.

  # timethese - run several chunks of code several times
  # cmpthese - print results of timethese as a comparison chart
  # timediff ( T1, T2 )
  #   Returns the difference between two Benchmark times as a
  #   Benchmark object suitable for passing to timestr().
  # timestr ( TIMEDIFF, [ STYLE, [ FORMAT ] ] )
  #   Returns a string that formats the times in the TIMEDIFF object
  #   in the requested STYLE. TIMEDIFF is expected to be a Benchmark
  #   object similar to that returned by timediff().

  # # ...or in two stages
  # $results = timethese($count,
  #   {
  #    'Name1' => sub { ...code1... },
  #    'Name2' => sub { ...code2... },
  #   },
  #   'none'
  # );
  # cmpthese( $results ) ;

  # Specifying your tests as strings usually produces results that are more
  # accurate. Pass arguments by using package variables.
  # Note: Use short names on the left-hand-side to get a more compact table.
  # TODO: Fix the list of subroutines which produces warnings or errors.
  # Readonly my $COUNT = 200;
  # cmpthese $COUNT, {
  # Readonly my $CPU_SECONDS = -0.1;
  #   my @array_of_arrays = cmpthese $CPU_SECONDS, {
  #     version
  #       => 'my $str = display_version(qv(\'1.0.0\'))',
  #     usage
  #       => 'my $str = display_usage($USAGE)',
  #     manual
  #       => 'my $str = display_manual(\'MyModulino.pl\')',
  #     help
  #       => 'my $str = display_help($PROGRAM, $USAGE)',
  #     # Warning: Use of uninitialized value $verbose_argument in concatenation
  #     # (.) or string at MyModulino.pl line 563.
  #     verbose
  #       => 'my $str = display_verbose_argument($ARGV{\'-v\'})',
  #     output_arg
  #       => 'my $str = display_output_file_argument($ARGV{\'-o\'})',
  #     input_args
  #       => 'my $str = display_input_file_arguments($ARGV{q{--}})',
  #     input_arg
  #       => 'my $str = display_input_file_argument($ARGV{\'-i\'})',
  #     # Error
  #     # unique_input_files
  #     #  => 'my @array = generate_unique_input_files_array('
  #     #   .'\'C:\\Users\\machine_user\\\')',
  #     command_line
  #       => 'my $ref = process_command_line_options($PROGRAM, $VERSION, $USAGE)',
  #     # Error
  #     # read_data_from_stdin
  #     #  => 'my $nbr = read_data_from_stdin_into_a_flat_file('
  #     #   .'\'C:\\Users\\machine_user\\\')',
  #     # Warning
  #     # data_and_end
  #     #  => 'my $nbr = _display_data_between_data_and_end()',
  #     # Warning
  #     # header
  #     #   => 'my $str = display_header({
  #     #                   program=>$PROGRAM,
  #     #                   version=>$VERSION,
  #     #                   usage  =>$USAGE,
  #     #                   argv   =>@ARGV
  #     #                 })',
  #     # Error
  #     # main
  #     #  => 'my $nbr = main(@ARGV)',
  #   };

  # Readonly my $CPU_SECONDS = -0.1; # Minimum
  Readonly my $CPU_SECONDS = -10;
  # Note: 10 CPU Seconds (-10) is recommended. It may take a while.
  my @array_of_arrays = cmpthese $CPU_SECONDS, {
    hash_ref  => 'my $nbr = write_or_display_results($MyModulino::hash_ref)',
    hash_ref2 => 'my $nbr = write_or_display_results($MyModulino::hash_ref2)',
  };
  $return_val = print "\n[$title]\n";

  my $t1 = Benchmark->new;
  my $td = timediff($t1, $t0);
  $return_val = print 'The code took: ',timestr($td),"\n";

  # $return_val = print 'Iterations: ' . $t1->iters . "\n";

  return @array_of_arrays;
} # End _compare


#############################################################################
# Usage: _display_argv_hash();
# Purpose: Displays contents of global variable %ARGV.
# Returns: String containing contents of global variable %ARGV.
# Parameters: None
# Throws: No exceptions
# Comments: This is the hash, %ARGV, from Getopt::Euclid, not @ARGV.
#           For internal use only.
sub _display_argv_hash {
  my ($none) = @_;
  if ($ARGV{'-v'}) { warn "procedure _display_argv_hash\n"; }

  my $str = _print_data_dumper(\%ARGV);
  # $return_val = print $str;

  return $str;
} # End _display_argv_hash


#############################################################################
# Usage: _display_data_between_data_and_end();
# Purpose: Read data between the __DATA__ and __END__ markers and output it
#          to standard output.
# Returns: Success (0)
# Parameters: None
# Throws: No exceptions
# Comments: For internal use only.
#           This subroutine is not necessary when __END__ comes before
#           __DATA__.
sub _display_data_between_data_and_end {
  my ($none) = @_;
  if ($ARGV{'-v'}) { $return_val =
    warn "procedure _display_data_between_data_and_end\n";
  }
  # Read the program information between __DATA__ and __END__.
  # By default <DATA> will read from __DATA__ until the end of the file.

  DATA_LINE:
  while (defined(my $line = <DATA>)) {
    # last DATA_LINE if $line eq "__END__\n"; # works
    last DATA_LINE if $line =~ /__END__/xms;
    $return_val = print $line;
  }
  return $SUCCESS;
} # End _display_data_between_data_and_end


#############################################################################
# Usage: _memory($argument_ref);
# Purpose: Get the memory used by a data structure.
# Returns: 0
# Parameters: a reference to the structure from which to get memory
# Throws: No exceptions
# Comments: For internal use only. Mildly useful.
# MEMORY COMPARISON

# hash ref with [@lines]: winner on memory
# hash alone:           400 bytes
# data alone:         1,070 bytes
# ===============================
# total:              1,470 bytes

# hash ref with \@lines:
# hash alone:           400 bytes
# data alone:         1,086 bytes
# ===============================
# total:              1,486 bytes
sub _memory {
  my ($argument_ref) = @_;
  if ($ARGV{'-v'}) { warn "procedure _memory\n"; }

  use Devel::Size qw( size total_size );
  # my $hash_mem = size(\%hash);
  my $hash_mem = size($argument_ref);
  # my $total_mem = total_size(\%hash);
  my $total_mem = total_size($argument_ref);
  my $data_mem = $total_mem - $hash_mem;

  use Perl6::Form;
  $return_val = print "Reference:\n";
  $return_val = print form(
    'hash alone: {>>>,>>>,>>>} bytes', $hash_mem,
    'data alone: {>>>,>>>,>>>} bytes', $data_mem,
    '===============================',
    'total:      {>>>,>>>,>>>} bytes', $total_mem,
  );
  return $SUCCESS;
} # End _memory


#############################################################################
# Usage: _print_data_dumper($arg_ref);
# Purpose: Displays contents of data dumper argument.
# Returns: String of data dumper results
# Parameters: argument reference to send to data dumper
# Throws: No exceptions
# Comments: The data dumper only works on references, not arrays and hashes.
#           You could always add a \ in front of the variable when calling.
#           For internal use only.
sub _print_data_dumper {
  my ($arg_ref) = @_;
  if ($ARGV{'-v'}) { warn "procedure _print_data_dumper\n"; }

  # $output_file_info = {
  #                       'output_path' => 'C:\\Users\\machine_user\\output.txt',
  #                       'lines' => [
  #                                    {
  #                                      'field3' => ' field3',
  #                                      'field1' => 'field1',
  #                                      'field2' => ' field2'
  #                                    },
  #                                    {
  #                                      'field2' => ' Mausolf',
  #                                      'field1' => 'Tom',
  #                                      'field3' => ' 1982'
  #                                    },
  #                                    {
  #                                      'field2' => ' Something',
  #                                      'field3' => ' 1983',
  #                                      'field1' => 'Joe'
  #                                    }
  #                                  ],
  #                       'output_fh' => undef,
  #                       'output_file_was_entered' => ''
  #                     };

  use Data::Dumper qw( Dumper );
  my $str = Dumper($arg_ref); # easy to use
  warn "$str\n";
  # The first argument is an anonymous array of values to be dumped. The
  # optional second argument is an anonymous array of names for the values.
  # $str = Data::Dumper->Dump([ $arg_ref ], [qw(output_file_info)]);
  # $return_val = print $str;
  return $str;
} # End _print_data_dumper

1


# Note: The function which reads __DATA__ did not work when placed after
# __END__. It works here.
__DATA__
read one
undef
read two

__END__


=head1 NAME

    MyModulino.pl - This program reads one or more input files, or STDIN by
    default, parses the input, and sends the results to an output file, or
    STDOUT by default, depending on command line arguments.

=head1 VERSION

    This documentation refers to MyModulino version 1.0.0.

=head1 USAGE

    perl MyModulino.pl [-i[nfile] [=] C:\Users\machine_user\input.txt ]
    [-o[utfile] [=] C:\Users\machine_user\output.txt ][-v[erbose] ][-h[elp] ]
    [--help ][--man ][--usage ][--version ][/? ]
    [-- C:\\Users\\machine_user\\input2.txt [C:\\Users\\machine_user\\input3.txt ...]]

    Parameters can be specified in any order, except for
    [-- file1, file2, etc.]. These files must appear at the end of the
    argument list. Any output and or input file must exist if specified.

    Be careful when modifying this documentation. It is used by
    Getopt::Euclid to parse command line arguments.

=head1 EXAMPLES

    perl MyModulino.pl -iC:\Users\machine_user\input.txt
    -o = C:\Users\user_machine\output.txt

    perl MyModulino.pl -o = C:\Users\user_machine\output.txt
    -- C:\Users\machine_user\input.txt C:\Users\machine_user\input2.txt

    perl MyModulino.pl -v  # verbose

    perl MyModulino.pl /?  # help
    perl MyModulino.pl --help
    perl MyModulino.pl --man
    perl MyModulino.pl --usage
    perl MyModulino.pl --version

=head1 REQUIRED ARGUMENTS

    None.

    Getopt::Euclid uses the specifications in this POD section to build
    a parser for command-line arguments. That parser requires that every
    one of the specified arguments is present in any command-line
    invocation.

    Caveat: Do not put additional subheadings (=headX) inside the
    REQUIRED ARGUMENTS section.

=head1 OPTIONS

    See items below.

    Getopt::Euclid uses the specifications in this POD section to build
    a parser for command-line arguments. That parser does not require
    that any of the specified arguments is actually present in a
    command-line invocation.

=over

=item  -i[nfile] [=] <file>

Specify input file. If not specified, standard input is used.

=for Euclid:
    file.type:    readable
    file.type.error: The <file> must exist: file. Try specifying the complete path to an existing <file>.
    file.default: '-'

=begin section

    This is the other way (than for) to write private code which won't be
    output.

    Use it if you have multiple paragraphs.

=end section

=item  -o[utfile] [=] <file>

Specify output file. If not specified, standard output is used.

=for Euclid:
    file.type:    writable
    file.type.error: The <file> must exist: file. Try specifying the complete path.
    file.default: '-'

=item -v[erbose]

Print all warnings.

=for Default: Set verbose default to 0.

=item -h[elp]

Print usage help.

=item --help

Print usage help.

=item /?

Print usage help.

=item --man

Print the full manual.

=item --usage

Print program usage.

=item --version

Print version.

=begin section

item <file>

Read in a file to process. This does work. It is listed under $ARGV{'<file>'}.

for Euclid:
    file.type:    readable
    file.type.error: The <file> must exist: file. Try specifying the complete path.

=end section

=item -- <file>...

Read in a list of files to process.

=for Euclid:
    file.type:    readable
    file.type.error: The <file> must exist: file. Try specifying the complete path.

=back

=head1 SUBROUTINES

=over

=item run

Runs the program using @ARGV from the command line. This is the first
subroutine called.

=item main

Main procedure of the program. This program reads one or more input files,
or STDIN by default, parses the input, and sends the results to an output
file, or STDOUT by default, depending on command line arguments.

=item display_header

Displays the program header

=item process_command_line_options

Executes command line options. Getopt::Euclid may produce output for some
standard options such as --help, --man, --usage, and --version.

=item process_line

Return pertinant information from the line reference.

=item parse_csv_input_files_and_write_to_output

Parse every CSV input file and write it to an output file if appropriate.

=item parse_lines_in_csv_input_file

Get back usable information from the input file and put it in an array.

=item write_or_display_results

Save or display the results according to what the user entered.

=item display_help

Displays program help. Corresponds to --help on the command line.

=item display_input_file_argument

Displays whether an input file was specified. Corresponds to -i on the
command line.

=item display_input_file_arguments

Displays whether input files were specified. Corresponds to -- <file1>
<file2>... on the command line.

=item display_manual

Displays program manual. Corresponds to --man on the command line.

=item display_output_file_argument

Displays whether an output file was specified. Corresponds to -o on the
command line.

=item display_usage

Displays program usage, a string which describes the syntax for the command
line. Corresponds to --usage on the command line.

=item display_verbose_argument

Displays whether the verbose command line option was entered. Corresponds to
-v[erbose] on the command line.

=item display_version

Displays program version. Corresponds to --version on the command line.

=item generate_unique_input_files_array

Generate a unique list of input files given the arguments specified on the
command line. This ensures duplicate arguments are removed from the
-i=<file1> and -- <file2> <field3>... options.

=item read_data_from_stdin_into_a_flat_file

This subroutine gets input from the user on the command line and writes it
to an input file for further processing by the program. A subroutine
expects a file handle and not a string as input.

=item get_data_from_user_and_print_to_input_file

Read data from standard in. Reading ends after an empty line. Print input to
an input file for further processing.

=item process_piped_input

Handle piped input. Read that input using <ARGV> or <>.

=back

=head1 DIAGNOSTICS

A list of every error and warning message that the application can generate
(even the ones that will "never happen"), with a full explanation of each
problem, one or more likely causes, and any suggested remedies. If the
application generates exit status codes (e.g. under Unix) then list the exit
status associated with each error.

=head2 Error:

=head2 The file must exist

"The <file> must exist: input.txt. Try specifying the complete path.

Try this for usage help: MyModulino.pl --help
Or this for full manual: MyModulino.pl --man"

  * Problem: You entered a filepath for a file which does not exist.
  * Likely causes: You may have entered only the file name, when the program
    expects a path. Or, you may have put the name in single quotes, when
    no quotes or double quotes are expected.
  * Suggested remedy: Re-enter the complete path of the file with no quotes
    or double quotes.

=head2 Unknown argument

"Unknown argument: arg1 arg2

Try this for usage help: MyModulino.pl --help
Or this for full manual: MyModulino.pl --man"

  * Problem: You entered one or more arguments which the program was not
    expecting.
  * Likely causes: Your entry did not meet the usage standards. Try putting
    a dash (-) in front of the option. Or, make sure you did not duplicate a
    command line option.
  * Suggested remedy: Re-enter the command without the additional arguments.

=head2 sysread() on closed filehandle

"sysread() on closed filehandle $input_fh at
C:/Strawberry/perl/vendor/lib/File/Slurp.pm line 225.
Error: read_file 'GLOB(0x3370210)' - loop sysread: Bad file descriptor at
C:/Strawberry/perl/site/lib/Text/CSV/Simple.pm line 153."

  * Problem: Unhelpful error message appears. There appears to be a problem
    with the $input_fh.
  * Likely causes: There is a problem with an input file argument. Make sure
    you did not include an option after -- other than input files, as the
    program may interpret that as an input file.
  * Suggested remedy: Check your input arguments. Be sure all your input
    files exist.

=head2 Error: Can't read GLOB

Error: Can't read GLOB(0x3510c88) at
C:/Strawberry/perl/site/lib/Text/CSV/Simple.pm line 153, <> line 1.

  * Problem: Can't convert input into comma separated value (CSV) format.
  * Likely causes: input may have come from user-prompted input and not
    input files, both of which are expected to be in comma separated value
    format.
  * Suggested remedy: Retry the program using the same parameters and
    enter the values separated by commas.

=head2 Use of uninitialized value in concatenation (.) or string

"Use of uninitialized value in concatenation (.) or string at MyModulino.pl
line 675, <> line 3."

  * Problem: Warning that a variable without a value was used in a string.
  * Likely causes: too few values were entered on a line of input,
    either read in by the user or contained in an input file.
  * Suggested remedy: Enter the same number of values as the header, or
    remove the line from the input.

=head2 Failed on ...

Failed on ....

  * Problem: The program failed getting CSV from the input.
  * Likely causes: The input was not formatted as CSV.
  * Suggested remedy: The input should be reformatted to fit CSV, with double
    quotes and commas between items. Or, you should change the settings in
    the program.

=head1 EXIT STATUS

Exit codes:

=over

=item exit (0);

If EXPR is omitted, exits with 0 status. The only universally recognized
values for EXPR are 0 for success and 1 for error; other values are
subject to interpretation depending on the environment in which the Perl
program is running.

  Command line options such as help, man, usage, and version call exit with
  the 0 exit code for success.

=item exit (-1);

Errors return a negative code. TODO: Consider whether this value should be 1
for failure.

=back

=head1 CONFIGURATION

    Configuration is done for command line parameters with the Getopt::Euclid
    package using syntax in these pod statements.

    Configuration for Text::CSV::Simple is specified in the program.

=head1 DEPENDENCIES

    Getopt::Euclid
    Text::CSV::Simple
    List::MoreUtils qw(uniq);
    Readonly;
    English qw(-no_match_vars);
    Benchmark
    Data::Dumper
    Regexp::Common

=head1 INCOMPATIBILITIES

    None

=head1 BUGS AND LIMITATIONS

    Bug reports and other feedback are most welcome.

    Unmatched back at C:/Strawberry/perl/site/lib/Getopt/Euclid.pm line 1102.

    WARNINGS FROM PERL CRITIC:
    C:\Strawberry\perl\lib>perlcritic --severity 1 MyModulino.pl
    Code is not tidy at line 1, column 1.  See page 33 of PBP.  (Severity: 1)
    Postfix control "unless" used at line 16, column 25.  See pages 96,97 of PBP.  (Severity: 2)
    Always unpack @_ first at line 66, column 1.  See page 178 of PBP.  (Severity: 4)
    Package variable declared or used at line 68, column 3.  See pages 73,75 of PBP.  (Severity: 3)
    String *may* require interpolation at line 71, column 33.  See page 51 of PBP.  (Severity: 1)
    String *may* require interpolation at line 72, column 33.  See page 51 of PBP.  (Severity: 1)
    String *may* require interpolation at line 73, column 33.  See page 51 of PBP.  (Severity: 1)
    Subroutine "main" with high complexity score (42) at line 110, column 1.  Consider refactoring.  (Severity: 3)
    Close filehandles as soon as possible after opening them at line 169, column 3.  See page 209 of PBP.  (Severity: 4)
    Close filehandles as soon as possible after opening them at line 211, column 5.  See page 209 of PBP.  (Severity: 4)
    Backtick operator used at line 496, column 15.  Use IPC::Open3 instead.  (Severity: 3)

=head1 SEE ALSO

    Getopt::Euclid
    Text::CSV::Simple
    use List::MoreUtils qw(uniq);

=head1 AUTHOR

    Thomas (decline@decline.com)

=head1 LICENSE AND COPYRIGHT

    Copyright (c) 2017, Thomas Mausolf. All Rights Reserved.

=cut

#print "You are guided on what to enter. Don't rely on your memory.\n";
#print "1.Enter the name of an input file or press enter: \n";

# Two approaches: excellent-design (through thought and iteration) OR
# Get it working. Don't be overly concerned with how it is implemented.
# Get it working.

#foreach (my $filesToEnter in glob("\.\\perldoc_.*\.txt")) {
#  print $filesToEnter . ": \n\n";
#}
#display_example_using_cmd('dir perldoc* /B');
# glob

# Quote and Quote-like Operators
# -------------------------------------------------------------------
#    Customary  Generic        Meaning	     Interpolates
#	''	 q{}	      Literal		  no
#	""	qq{}	      Literal		  yes
#	``	qx{}	      Command		  yes*
#		qw{}	     Word list		  no
#	//	 m{}	   Pattern match	  yes*
#		qr{}	      Pattern		  yes*
#		 s{}{}	    Substitution	  yes*
#		tr{}{}	  Transliteration	  no (but see below)
#        <<EOF                 here-doc            yes*
#
#	* unless the delimiter is ''.

# File test operators
# -------------------------------------------------------------------
# -r  File is readable by effective uid/gid.
# -w  File is writable by effective uid/gid.
# -x  File is executable by effective uid/gid.
# -o  File is owned by effective uid.
#
# -R  File is readable by real uid/gid.
# -W  File is writable by real uid/gid.
# -X  File is executable by real uid/gid.
# -O  File is owned by real uid.
#
# -e  File exists.
# -z  File has zero size (is empty).
# -s  File has nonzero size (returns size in bytes).
#
# -f  File is a plain file.
# -d  File is a directory.
# -l  File is a symbolic link (false if symlinks aren't
#     supported by the file system).
# -p  File is a named pipe (FIFO), or Filehandle is a pipe.
# -S  File is a socket.
# -b  File is a block special file.
# -c  File is a character special file.
# -t  Filehandle is opened to a tty.
#
# -u  File has setuid bit set.
# -g  File has setgid bit set.
# -k  File has sticky bit set.
#
# -T  File is an ASCII or UTF-8 text file (heuristic guess).
# -B  File is a "binary" file (opposite of -T).
#
# -M  Script start time minus file modification time, in days.
# -A  Same for access time.
# -C  Same for inode change time (Unix, may differ for other
#     platforms)

# quotemeta
# wantarray

#my $nbr = _common_regexp();
# _memory();
# my @array_of_arrays = _compare('0.1 CPU SECONDS');
# _display_data_between_data_and_end();
# _display_argv_hash();

#foreach my $key (keys %ENV) {
#  print "$key => $ENV{$key}\n";
#}

# # Never subscript more than once in a loop
# # Avoid subscripting arrays or hashes with loops. Iterate the values directly.
# # To delete from a hash use a hash slice.
# # Place next, last, redo, return, goto, die, croak, and throw as far left as possible.
# # Use map instead of for when generating new lists from old.
# # Use grep and first instead of for when searching for values in a list.
# # Use for instead of map when transforming a list in place.
# # Never modify $_ in a list function.
# # No map, grep, or first block should ever have a side effect.
# # In particular, no map, grep, or first block should ever modify $_.
# # If you need side effects in your map, grep, or first block, then rewrite
# #   the code as a for loop instead.
# # Use a table lookup instead of a cascading if.
# # Reject as many iterations as possible, as early as possible.
# # Label every loop with every next, last, or redo.
# use Data::Alias;
#
# for my $agent_num (0..$#operatives) {
#   alias my $agent = $operatives[$agent_num];
#
#   print "Checking agent $agent_num\n";
#
#   if ($on_disavowed_list($agent}) {
#
#     $agent = '[DISAVOWED]';
#
# }}

# use Data::Alias;
#for my $name (keys %client_named) {
#  alias my $client_info = $client_named{$name};
#  my $inactive = $client_info->inactivity();
#
#  print "Checking client $name\n";
#
#  $client_info
#    = $inactive > $ONE_YEAR   ? Client::Moribund->new({ from => $client_info })
#    : $inactive > $SIX_MONTHS ?   Client::Silver->new({ from => $client_info })
#    : $inactive > $SIX_WEEKS  ?     Client::Gold->new({ from => $client_info })
#    :                           Client::Platinum->new({ from => $client_info })
#}

# @pm_files_without_pl_files
#     = grep {
#           my $file = $_;
#           $file =~ s/.pm\z/.pl/xms;
#           !-e $file        } @pm_files;

#if ($ARGV{'-v'}) {
#  warn 'procedure main lines: ' . (scalar (@lines)) . "\n";

#  foreach my $value (@lines) {
#    warn "$value->{'field1'} $value->{'field2'} $value->{'field3'}\n";
#  }
#}

# Perl @ARRAY s and %HASH es are all internally one-dimensional. They can
# hold only scalar values (meaning a string, number, or a reference).
# They cannot directly contain other arrays or hashes, but instead
# contain references to other arrays or hashes.
# If you write just "[]", you get a new, empty anonymous array. If you
# write just "{}", you get a new, empty anonymous hash.
# Note: change my to our for _compare($title);

# Metacharacters: {}[]()^$.|*+?\
