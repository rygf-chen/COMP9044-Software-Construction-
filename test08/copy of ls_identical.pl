#!/usr/bin/perl -w

use File::Compare;

$d1=$ARGV[0];
$d2=$ARGV[1];

for $f1(glob "$d1/*"){
    $f2=$f1=~ s/.*\///gr;
    if (compare($f1, "$d2/$f2")!=0){
        next;
    }
    else{
        print "$f2\n";
    }
}