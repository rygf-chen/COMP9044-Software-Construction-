#!/usr/bin/perl -w

sub total_words{
    ($total_path)=@_;
    open F, "<", "$total_path" or die "cannot open!";
    my $num=0;
    while ($line=<F>){
        my @list = split /[^a-z]/i, $line;
        foreach  $words (@list){
        $num += $#words if $words !~ /^$/;
        }
    }
    close F;
    $result = abs($num);
    return $result;
}

sub count_word{
    ($match_word,$match_file)=@_;
    $match_W=uc($match_word);
    open CF, "<", "$match_file" or die "cannot open!";
    $count_num=0;
    while ($count_line=<CF>){
        $lines=uc($count_line);
        @c_words=split /\b$match_W\b/,$lines;
        $count_num += $#c_words;
    }
    close CF;
    return $count_num;
}


foreach $file (glob "lyrics/*.txt") {
    $total=total_words($file);
    $times=count_word($ARGV[0],$file);
    $file=~ s/lyrics\///;
    $file=~ s/\.txt//;
    $name=$file=~ s/_/ /gr;
    printf "log((%d+1)/%6d) = %8.4f %s\n", $times, $total, log(($times+1)/$total),$name;
}