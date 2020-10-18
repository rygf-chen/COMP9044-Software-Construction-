#!/usr/bin/perl -w
sub max_count{
	my @list=@_;
	my $max=$list[0];
	for $temp (@list){
		if($max >= $temp){
            next;
		}
        else{
            $max = $temp;
        }
	}

	return $max;
}

while ($line=<STDIN>){
    my @list=();
	@list=$line=~m/-?\d*\.?\d+/g;
	if(!@list){
        next;
	}
    else{
        push @max_number,max_count(@list);
		push @line_lists,$line;
    }
}

$max_line_num=max_count(@max_number);
$num=0;
while ($num<@max_number){
	if ($max_number[$num]==$max_line_num){
		print "$line_lists[$num]";
	}
    $num++;
}
