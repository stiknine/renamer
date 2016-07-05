# renamer
Another Perl file renaming script...

Parse file names and directory names for special characters: ' " # \ [] | {} () ; , ~ ! @ $ % ^ * ? ` < >

Replacing characters ' " # with an (-) hyphen<br />
Replacing characters \ [] | {} () ; , ~ with an (_) underscore<br />
Removing characters ! @ $ % ^ * ? ` < ><br />
Removing leading/trailing spaces<br />
<br />
<br />
Originally written to rename thousands of files stored on a Xsan file system which supported all special characters except : / in the filename to a NTFS based file system.
