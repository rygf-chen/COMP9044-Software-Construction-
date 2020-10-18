#!/usr/bin/perl -w
$filename=$ARGV[0];
open F,'<',"$filename" or die "cannot open $filename!";
while($content=<F>){
	chomp $content;
	@list=split //,$content;
	$file{$content}=@list;
}
close F;
my @files = sort {$file{$a} <=> $file{$b}} sort keys %file;
for $line (@files){
	print"$line\n";
}


