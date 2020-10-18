#!/usr/bin/perl -w
use experimental 'smartmatch';
no warnings;

sub findfiles {
    my ($file) = @_;
    my @checklist = ();
    # return if ($file ~~ @usedfile);
    open my $check, '<', $file;
    while ($line = <$check>){
        if ($line =~ /^#include \"(.*)\"/){
            push @checklist, $1;          
        }
        if ($line =~ /^\s*(int|void)\s*main\s*\(/){
            $main = $file;
        }
    }
    push @usedfile, $file;
    foreach $content(@checklist){
        next if ($content ~~ @usedfile);
        findfiles($content);
    }
    close $check;
}

%result = ();
@usedfile = ();
$main = "";
@output2 = ();

foreach $file (glob("*.c")){
    findfiles($file);
    $file =~ s?(.*)\.c?$1\.o?;
    foreach $i(@usedfile){
        $result{$file}{$i} = 1;
    }
    @usedfile = ();
}



print "# Makefile generated at ";
system "date";
print "\n";

print "CC = gcc\n";
print "CFLAGS = -Wall -g\n";
print "\n";

$filename = $main;
$filename =~ s?\.c??;
print "$filename:";
foreach $k (keys %result){
    print "\t$k";
    push @output2, $k;
}
print "\n";
print "\t\$\(CC\) \$\(CFLAGS\) -o \$\@ @output2\n";
print "\n";


foreach $x (keys %result){
    my $len =  values $result{$x};
    if ($len !=1 ){
        print "$x:";
        foreach $a (keys %{$result{$x}}){
        print "\t$a";
    }
    print "\n";
    }
}