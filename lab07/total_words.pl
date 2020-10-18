#!/usr/bin/perl -w

$num=0;
while ($line=<STDIN>){
	@list = split /[^a-z]/i, $line;
	foreach $words (@list){
	$num += $#words if $words !~ /^$/;
	}
}
$result = abs($num);
print "$result words\n";