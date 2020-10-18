#!/usr/bin/perl -w

# if (@ARGV[0] eq '-d'){
#     $filename=$ARGV[1];
#     $flag = 0;
# }
# else{
#     $filename=$ARGV;
#     $flag = 1;
# }

foreach $file (glob "lyrics/*.txt") {
    open FN , "<" ,"$file" or die "cannot open!\n";
    $file=~ s/lyrics\///;
    $file=~ s/\.txt//;
    $file=~ s/_/ /g;
    while ($line=<FN>){
        $line =lc($line);
        @words = split /[^a-z]/,$line;
        foreach $word (@words){
            $word_times{$file}{$word}+=1;
        }
        $total_count = ($line =~ s/\W?[a-z]+\W?//g);
        $word_total{$file}+=$total_count;
    }
    close FN;
}   


@name = keys %word_total;
foreach my $final_name (@ARGV){
	open F , "<","$final_name" or die "can not open";
    my %result=();
    while ($line=<F>){
        $line =lc($line);
		@lyrics = split /[^a-z]+/, $line;
		foreach $lyric ( @lyrics ){
            foreach $singer (@name){
                if(exists($word_times{$singer}{$lyric})){
                    $result{$singer}+=log((($word_times{$singer}{$lyric})+1)/$word_total{$singer});
                }
                else{
                    $result{$singer}+=log(1/$word_total{$singer});
                }
            }
		}
	}
        # if ($flag == 0){
        #     foreach  $star ( sort{$result{$b} <=> $result{$a}} keys %result) {
        #         printf "$final_name: log_probability of %.1f for $star\n",$result{$star};
        #     }
        # }
        foreach  $star ( sort{$result{$b} <=> $result{$a}} keys %result) {
                printf "$final_name most resembles the work of $star (log-probability=%.1f)\n",$result{$star};
                last;
        }
    close F;
}