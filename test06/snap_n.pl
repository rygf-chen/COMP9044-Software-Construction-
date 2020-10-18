#!/usr/bin/perl -w
$num=$ARGV[0];
while($line=<STDIN>){
	chomp $line;
	if (exists($data{$line})){
		$data{$line}+=1;
	}
	else{
		$data{$line}=0;
        $data{$line}++;
	}
	if ($data{$line}==$num){
		print "Snap: $line\n";
		exit 0;
	}
}