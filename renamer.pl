#!/usr/bin/perl -w
#
# parse file names and directory names for special characters:
# ' " # \ [] | {} () ; , ~ ! @ $ % ^ * ? ` < >
# replacing characters ' " # with an (-) hyphen
# replacing characters \ [] | {} () ; , ~ with an (_) underscore
# removing characters ! @ $ % ^ * ? ` < >
# removing leading/trailing spaces
#
# logs result to file, turn renaming on/off
# if no directory is specified, parses current directory "."
# default log file if not specified: filenames.txt
# default log file location: same place script is ran "."
#
#
# 2007
# Author: Harley Newton
# This software is provided FREE with NO WARRANTY. Use at your own risk.
#
#
# use: ./renamer.pl <rename files: yes, no> <dir> <log file>
#


use strict;


# setup
my $namePrefix = "_ch_"; # prefix for new filenames

my $renameFiles = shift;
my $dir = shift;
my $logfile = shift;


# directory to parse
if (!defined($dir))
{
	# default directory
	$dir = ".";
}

if (!defined($logfile))
{
	# default log file name
	$logfile = "filenames.txt";
}

# open log file
open (LOG, ">>$logfile") or die "Couldn't open log: $!";

# run the parse routine
parseFiles($dir, $logfile);

# close log
close(LOG);

#
# parse through files and if set rename them
#
sub parseFiles {
	
	my $dir = shift;
	my $logfile = shift;

	# get files/directories to parse
	opendir(DIR, $dir);

	# ignore "." or ".."
	my @files = grep !/^\.\.?\z/, readdir(DIR);
	closedir(DIR);

	foreach my $file(@files)
	{
		if (-d "$dir/$file")
		{
			parseFiles("$dir/$file");
		}
		
		#
		# NO SPECIAL CHARACTERS
		# ' " # \ [] | {} () ; , ~ ! @ $ % ^ * ? ` < >
		#

		# files
		my $newfile = $file;
		$newfile =~ tr{'"#&+=}{-}; # replace ' " # with -
		$newfile =~ tr{\\[]|;,\{\}\(\)~}{_}; # replace \ [] | {} () ; , ~ with _
		$newfile =~ tr/!@%*^`\?\$<>//d; # remove these ! @ $ % ^ * ? ` < >
		$newfile =~ s/^\s+//; # remove leading spaces
		$newfile =~ s/\s+$//; # remove trailing spaces

		# directories
		my $newdir = $dir;
		$newdir =~ tr{'"#&+=}{-}; # replace ' " # with -
		$newdir =~ tr{\\[]|;,\{\}\(\)~}{_}; # replace \ [] | {} () ; , ~ with _
		$newdir =~ tr/!@%*^`\?\$<>//d; # remove these ! @ $ % ^ * ? ` < >
		$newdir =~ s/^\s+//; # remove leading spaces
		$newdir =~ s/\s+$//; # remove trailing spaces

		# do something
		if ($newfile ne $file or $newdir ne $dir)
		{
			if ($newfile !~ m/^\./) # ignore hidden files ("." dot files)
			{
				if ($renameFiles eq "yes") {
					# rename files and directories output warning on rename errors
					rename "$dir/$file","$dir/$namePrefix$newfile" or warn "Problems renaming $dir/$file --> $dir/$namePrefix$newfile: $!\n";
					print LOG "Renamed: \"$dir/$file\" TO \"$newdir/$namePrefix$newfile\"\n";
				}
				else {
					print LOG "Need to rename: \"$dir/$file\" TO \"$newdir/$namePrefix$newfile\"\n";
				}
			}
		}
	}
}
