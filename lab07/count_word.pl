#!/usr/bin/perl -w
$num=0;
$word=uc($ARGV[0]);
while ($line=<STDIN>){
    $lines=uc($line);
    @words=split /\b$word\b/,$lines;
    $num += $#words;
}
print "$word occurred $num times\n"