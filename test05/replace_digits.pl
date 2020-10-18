#!/usr/bin/perl -w

$file=$ARGV[0];
open F, "<", "$file" or die "can not open!";
@num=();
for $line (<F>){
    $line =~ s/[0-9]/#/g;
    push @num, $line;
}
close F;
open O, ">", "$file" or die "can not open!";
foreach $i ( @num ){
    print O $i;
}
close O;