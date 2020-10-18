#!/usr/bin/perl -w

for $input(@ARGV){
	if (exists($uniq{$input})){
	}
	else{
		$uniq{$input}++;
		unshift @result,$input;
	}
}
@output = reverse(@result);
print "@output\n";
