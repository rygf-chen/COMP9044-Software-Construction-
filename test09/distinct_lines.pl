#!/usr/bin/perl -w

$target = $ARGV[0];
%result = ();
$count = 0;

while ($line = <STDIN>){
    $count++;
    $line =~ s?\s*??g;
    $line = uc($line);
    $result{$line}++;
    $num = scalar keys %result;
    if ($num == $target){
        print "$target distinct lines seen after $count lines read.\n";
        exit 1;
    }
}

print "End of input reached after $count lines read - $target different lines not seen.\n";