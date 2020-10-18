#!/usr/bin/perl -w

use experimental 'smartmatch';

$timestamp = localtime();

@dates = split(/ /, $timestamp);

print "# Makefile generated at $dates[0] $dates[1] $dates[2] $dates[3] $dates[4] AEST $dates[5]\n";
print "\n";
print "CC = gcc\n";
print "CFLAGS = -Wall -g\n";

%dependencies = ();
@main_files = ();
@include_files = ();

sub check_files {
    my ($file) = @_;
    # ??????????????
    return if ($file_name ~~ @include_files);
    # ?????include files
    my @local_include_files = ();
    open $in, "$file" or die "Can not open $file: $!";
    while ($line = <$in>){
        if ($line =~ /\#include \"(.*)\"/){
            next if ($1 ~~ @include_files);
            push @local_include_files, $1;
        }
        if ($line =~ /^\s*(int|void)\s*main\s*\(/){
            push @main_files,"$file";
        }
    }
    close $in;
    push @include_files, $file;
    foreach $local_include_file (@local_include_files){
        check_files($local_include_file);
    }
}

# print "# Makefile generated at $timestamp\n";

# foreach c_file (glob("*.c")){
foreach $file (glob("*.c")){
    # get the file name
    check_files($file);
    shift @include_files;
    foreach $include_file (@include_files){
        $dependencies{$file}{$include_file} = 1;
    }
    @include_files = ();
}

foreach $main_file (@main_files){
    $o_file_name = $main_file;
    $o_file_name =~ s/\.c/\.o/;
    $file_name = $main_file;
    $file_name =~ s/\.c//;
    print "$file_name:\t";
    foreach $h_file (keys %{$dependencies{$main_file}}) {
        $h_file =~ s/\.h/\.o/;
        print "\t$h_file";
    }
    print "\t$o_file_name\n";
    print "\t\$(CC)\t\$(CFLAGS)\t-o\t\$\@";
    foreach $h_file (keys %{$dependencies{$main_file}}) {
        $h_file =~ s/\.h/\.o/;
        print "\t$h_file";
    }
    print "\t$o_file_name\n\n";
}

foreach $c_file (keys %dependencies) {
    $o_file = $c_file;
    $o_file =~ s/\.c/\.o/;
    print "$o_file:\t";
    foreach $h_file (keys %{$dependencies{$c_file}}) {
        print "\t$h_file";
    }
    print "\t$c_file\n";
}