#!/usr/bin/perl -w


@numbers=sort {$a <=> $b} @ARGV;
$result=@numbers[(scalar(@ARGV)-1)/2];
print "$result\n";