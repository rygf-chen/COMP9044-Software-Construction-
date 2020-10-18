#!/usr/bin/perl -w
use File::Copy;
$file = $ARGV[0];
$num = 0;
while (1){
	$filename = ".$file.$num";
	if ( ! -e $filename ){
		copy("$file","$filename") or die "Copy failed: $!";
		print "Backup of '$file' saved as '$filename'\n";
		exit 0;
	}
	$num++;
}

