#!/usr/bin/perl -w
use File::Copy;

sub save{
    $num=0;
    while (-d ".snapshot.$num"){
        $num++;
    }
    mkdir ".snapshot.$num";
    foreach $file (glob "*"){
        if ($file !~ m/snapshot\.pl/){
            copy("$file", ".snapshot.$num/$file");
        }
    }
    print "Creating snapshot $num\n";
}

if ($ARGV[0] eq "save"){
    save();
}
if (($ARGV[0] eq "load") and (@ARGV==2)){
    save();
    $n=$ARGV[1];
    foreach $f (glob ".snapshot.$n/*"){
        $target = $f =~ s/\.snapshot\.$n\///g;
        copy("$f", "./$target");
    }
    print "Restoring snapshot $n\n";
}