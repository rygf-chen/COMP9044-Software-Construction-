#!/usr/bin/perl -w
use File::Compare;

if (@ARGV == 0){
    print "Usage: ./identical_files.pl <files>\n";
    exit 0;
}

for $f1 (@ARGV){
    for $f2 (@ARGV){
        if (compare("$f1", "$f2") != 0){
            print "$f2 is not identical\n";
            exit 0;
        }
    }
}
print "All files are identical\n";