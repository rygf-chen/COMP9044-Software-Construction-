#!/usr/bin/perl -w

while (<STDIN>){
	s/[0-4]/</gi;
	s/[6-9]/>/gi;
	print;	

}


