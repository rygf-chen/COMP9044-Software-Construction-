#!/usr/bin/perl -w

@input = (<STDIN>);
@output = ();
foreach $line (@input){
    if ($line !~ /^\#(\d+)/){
        push @output, $line;
    }
    if ($line =~ /^\#(\d+)/){
        $num = $1;
        if ($num <= @input){
            push @output,$input[$num - 1];
        }
    }
}
foreach $out (@output){
    print "$out";
}

