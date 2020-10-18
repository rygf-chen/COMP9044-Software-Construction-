#!/usr/bin/perl -w
use List::MoreUtils qw(uniq);

@list = @ARGV;

@result = uniq @list;

print "@result\n";
