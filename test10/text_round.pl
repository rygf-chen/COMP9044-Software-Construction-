#!/usr/bin/perl -w


while ($line = <STDIN>){
    while ($line =~ /(\d+\.\d+)/){
        my $change = sprintf "%.0f", $1;
        $line =~ s?(\d+\.\d+)?$change?;
    }
    print "$line";
}
