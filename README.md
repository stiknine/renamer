# renamer
Another Perl file renaming script...

Parse file names and directory names for special characters:

' " # \ [] | {} () ; , ~ ! @ $ % ^ * ? ` < >

Replacing characters ' " # with an (-) hyphen

Replacing characters \ [] | {} () ; , ~ with an (_) underscore

Removing characters ! @ $ % ^ * ? ` < >

Removing leading/trailing spaces

Originally written to rename thousands of files stored on a Xsan file system which supported all special characters except : / in the filename to a NTFS based file system.
