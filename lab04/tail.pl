#!/usr/bin/perl -w

$nlines=10;
if (@ARGV+0 >=1 && $ARGV[0] =~ /-[0-9]+$/){
   $ARGV[0] =~ s/-//g;
   $nlines=$ARGV[0];
   shift @ARGV;
}
if (@ARGV+0 !=0){
  foreach $file (@ARGV){
    open $F, '<', $file or die "./tail.pl: can't open $file\n";
    if (@ARGV+0 >= 2){
        print "==> $file <==\n";
      }
      @line=<$F>;
      while (@line>$nlines){
        shift @line;
      }
      foreach $content (@line){
        print $content;
      }
      close $F;
  }
}else{
    @line=<STDIN>;
    while(@line>$nlines){
    	shift @line;
    	print @line;
  
    }
}
