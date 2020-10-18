#!/usr/bin/perl -w

while ($line=<>){
    @line=split(/\s+/,$line);
    @line=sort(@line);
    print "@line\n";
}