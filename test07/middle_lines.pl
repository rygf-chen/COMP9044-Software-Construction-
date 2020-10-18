#!/usr/bin/perl -w
open F,"<","$ARGV[0]" or die "cannot open!";
if (-z F){
	exit 0;
}
@temp=<F>;
close F;
$len = $#temp+1;
if ($len%2==0){
	print "$temp[$len/2-1]$temp[$len/2]";
}
else{
	print "$temp[($len-1)/2]";
}