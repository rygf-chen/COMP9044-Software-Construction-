#!/usr/bin/perl -w
@result=();
for	$line(@ARGV){
	if ($line =~ /[aAeEiIoOuU]{3}/g){
		unshift @result,$line;
	}
}
@result = reverse(@result);
print "@result\n";