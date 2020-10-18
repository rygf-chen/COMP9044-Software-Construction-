#!/usr/bin/perl -w

$name = $ARGV[0];
$file = $ARGV[1];
$num = 0;

open my $F, "<", $file or die "Cannot open $file";
@lines = <$F>;
close $F;

while (@lines){
    for my $line (@lines){
        if ($line =~ /\"how_many\": *([0-9]+),/){
            $nums = $1;
            next;
        }
        if ($line =~ /\"species\": *\"(.*)\"/){
            my $type = $1;
            if ($type eq $name){
                $num += $nums;
            }
        }     
    }
    last;
}
print "$num\n";