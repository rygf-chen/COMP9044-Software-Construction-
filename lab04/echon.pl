#!/usr/bin/perl -w
if (@ARGV+0 != 2){
	print "Usage: ./echon.pl <number of lines> <string>\n";
	exit 0;
}

if ($ARGV[0] =~ m/^[0-9]+$/){
	for($i=0;$i<$ARGV[0];$i++){
	print "$ARGV[1]\n";
}
}else{
	print "./echon.pl: argument 1 must be a non-negative integer\n";
	exit 0;
}


