#!/usr/bin/perl -w
use List::MoreUtils qw(uniq);
use LWP::Simple;
$coursename = $ARGV[0];
$url = "http://www.timetable.unsw.edu.au/current/COMPKENS.html";
$url =~ s/COMP/$coursename/;
$webpage = get $url;
@lines = split /\n/, $webpage;

@result = ();

foreach $line(@lines){
    if ($line =~ /$coursename/){
        if($line !~ />$coursename.*/){
            $line =~ s/.*href=\"//g;
            $line =~ s/\.html\">/ /g;
            $line =~ s/<\/a><\/td>//g;
            push @result,$line;
        }
    }
}
@result = uniq @result;
@result = sort @result;
foreach $out(@result){
    print "$out\n";
}