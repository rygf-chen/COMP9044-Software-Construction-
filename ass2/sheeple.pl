#!/usr/bin/perl -w

# z5236591 Jie Chen
# started at 01/08/20 16:00

# read files from STDIN
$filename = shift @ARGV;

# open file
open my $in, '<', "$filename";
@file_line = (<$in>);
close $in;


# $1, $2, $@, $#, $*
sub dollarsigns{
    my ($line) =@_;
    # $1 -> $ARGV[0]
    if ($line =~ /\$([0-9])/){
        my $temp = $1;
        $temp--;
        $line =~ s?\$([0-9])?\$ARGV[$temp]?;
    }
    # $@ -> @ARGV
    elsif ($line =~ /\$\@/){
        $line =~ s?\"*\$\@\"*?\@ARGV?;
    }
    # $# -> scalar @ARGV
    elsif ($line =~ /\$\#/){
        $line =~ s?\"*\'*\$\#\'*\"*?scalar \@ARGV?;
    }
    # a=$* -> @a = @ARGV
    elsif ($line =~ /\$\*/){    
        $line =~ s?(\$)(.*)\s*=\s*\"*\'*\$\*\'*\"*?\@$2= \@ARGV?;
    }
    return $line;
}

# check =
sub equal{
    my ($line) = @_;
    # change number=$((number + 1)) to number=`expr $number + 1`
    # it can reduce codes
    if ($line =~ /\$\(\((.*)\)\)/){
        $line =~ s?\$\(\((.*)\)\)?\`expr \$$1\`?;
    }

    # ignore the impact from if
    if ($line !~ /\s*if/){
        #   a=$2;
        #-> $a = $ARGV[1]; 
        if ($line =~ /(\s*)(.*)=\$([0-9]+)/){
            my $temp = $3;
            $temp--;
            $line =~ s?(\s*)(.*)=(.*)?$1\$$2=\$ARGV[$temp];?;
        }
        # a=0
        # $a = 0;
        elsif ($line =~ /(\s*)(.*)=([0-9]+)/){
            $line =~ s?(\s*)(.*)=([0-9]+)?$1\$$2 = $3;?;
        } 
        # a=$b
        # $a = $b;
        elsif ($line =~ /(\s*)(.*)=\$[a-zA-Z]/){
            $line =~ s?(\s*)(.*)=(.*)?$1\$$2 = $3;?;
        }
        # number=`expr $number + 1`
        # $number = $number + 1;
        elsif ($line =~ /(\s*)(.*)=`expr (.*) \\*(.*) (.*)`/){
            $line =~ s?(\s*)(.*)=`expr (.*) \\*(.*) (.*)`?$1\$$2 = $3 $4 $5;?;
        }
        #   a=hello
        #   $a = 'hello';
        elsif ($line =~ /(\s*)(.*)=(.*)/){
            $line =~ s?(\s*)(.*)=(.*)?$1\$$2 = '$3';?;
        }
    }
    return $line
}


# change ench into print
sub echon{
    my ($line) = @_;

    # echo 'hello world'
    # print "hello world\n";
    if ($line =~ /echo '(.*)'/){

        # echo '"Beauty is truth, truth beauty",  -  that is all'
        # print "\"Beauty is truth, truth beauty\",  -  that is all\n";
        if ($line =~ /echo '.*".*".*'/){
            $line =~ s?echo '(.*)"(.*)"(.*)'?print "$1\\"$2\\"$3\\n";?;
        } else {
        $line =~ s?echo '(.*)'?print "$1\\n";?;
        }
    }

    # echo "hello world"
    # print "hello world\n";
    elsif ($line =~ /echo "(.*)"/){
        $line =~ s?echo "(.*)"?print "$1\\n";?;
    }

    # echo My first argument is $1
    # print "My first argument is $ARGV[0]\n";
    elsif ($line =~ /echo (.*) \$([0-9]+)(.*)/){
        my $temp = $2;
        $temp--;
        $line =~ s?echo (.*) \$([0-9]+)(.*)?print "$1 \$ARGV[$temp]$3\\n";?;
    }

    # echo hello world
    # print "hellow world\n";
    elsif ($line =~ /echo (.*)/){
        $line =~ s?echo (.*)?print "$1\\n";?;
    }
    return $line
}

#  check for loop
sub forloop{
    my ($line) = @_;
    my @changed = ();
    my $string = '';
    if ($line =~ /\s*for (.*) in (.*)/){
        my @contents = split/ /,$2;
        foreach my $i (@contents){
            if ($i =~ /[a-zA-Z]/){
                $i ="'$i'";
            }
            push @changed, $i;
        $string = join ",",@changed;
    }
    $line ="foreach \$$1 \($string\) {\n";
    }
    return $line;
}

#check if
sub ifcheck{
    my ($line) = @_;
    # if [ * ] -> if test *
    if ($line =~ /\s*if \[ (.*) \]/){
        $line =~ s?if \[ (.*) \]?if test $1?;
    }
    # check the length of if statements to distinguish differernt if statements
    if ($line =~ /\s*if test (.*) (.*) (.*)/){
        my $vir1 = $1;
        my $vir2 = $2;
        my $vir3 = $3;
        if ($vir2 eq '='){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' eq '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' eq '$vir3'){?;
            }
        } 
        # -eq -> ==
        elsif ($vir2 eq '-eq'){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' \=\= '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' \=\= '$vir3'){?;
            }
        }
        # -le -> <=
        elsif ($vir2 eq '-le'){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' \<\= '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' \<\= '$vir3'){?;
            }
        }
        # -lt -> <
        elsif ($vir2 eq '-lt'){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' \< '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' \< '$vir3'){?;
            }
        }
        # -gt -> >
        elsif ($vir2 eq '-gt'){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' \> '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' \> '$vir3'){?;
            }
        }
        # -ge -> >=
        elsif ($vir2 eq '-ge'){
            if ($line !~ /elif/){
                $line =~ s?\s*if test (.*) (.*) (.*)?if ('$vir1' \>\= '$vir3'){?;
            } else {
                $line =~ s?\s*elif test (.*) (.*) (.*)?} elsif ('$vir1' \>\= '$vir3'){?;
            }
        }
    # if test -d /dev/null -> if (-d '/dev/null') {
    } elsif ($line =~ /\s*if test (.*) (.*)/){
        if ($2 =~ /\$(.*)/){
            $line =~ s?if test (.*) (.*)?if ($1 \$$2) {?;
        } else {
            $line =~ s?if test (.*) (.*)?if ($1 '$2') {?;
        }
    }
    # found a bug in test04
    # eg: if ('$start' <= '$finish')
    if ($line =~ /\('\$(.*)' (.*) '\$(.*)'\)/){
        print "xxxxxxxx$line\n";
        $line =~ s?\('\$(.*)' (.*) '\$(.*)'\)?\(\$$1 $2 \$$3\)?;
    }
    # if ($start <= '$finish')
    elsif ($line =~ /\(\$(.*) (.*) '\$(.*)'\)/){
        $line =~ s?\(\$(.*) (.*) '\$(.*)'\)?\(\$$1 $2 \$$3\)?;
    }
    # if ('$start' <= $finish)
    elsif ($line =~ /\('\$(.*)' (.*) \$(.*)\)/) {
        $line =~ s?\('\$(.*)' (.*) \$(.*)\)?\(\$$1 $2 \$$3\)?;
    }
    # if ('$start' <= '0')
    elsif ($line =~ /\('\$(.*)' (.*) '(\d)'\)/){
        $line =~ s?\('\$(.*)' (.*) '(\d)'\)?\(\$$1 $2 $3\)?;

    }
    return $line;
}

# while loop
sub whileloop{
    my ($line) = @_;

    # change while [ ] -> while test
    if ($line =~ /\s*while \[ (.*) \]/){
        $line =~ s?while \[ (.*) \]?while test $1?;
    }

    if ($line =~ /while test (.*) (.*) (.*)/){
        # -le -> <=
        if ($2 eq '-le'){
            $line =~ s?while test (.*) (.*) (.*)?while \($1 \<\= $3\) {?;
        }
        # -eq -> =
        elsif ($2 eq '-eq'){
            $line =~ s?while test (.*) (.*) (.*)?while \($1 \= $3\) {?;
        }
        # -lt -> <
        elsif ($2 eq '-lt'){
            $line =~ s?while test (.*) (.*) (.*)?while \($1 \< $3\) {?;
        }
        # -gt -> >
        elsif ($2 eq '-gt'){
            $line =~ s?while test (.*) (.*) (.*)?while \($1 \> $3\) {?;
        }
        # -ge -> >=
        elsif ($2 eq '-ge'){
            $line =~ s?while test (.*) (.*) (.*)?while \($1 \>\= $3\) {?;
        }
    }
    # while true -> while (1) {
    elsif ($line =~ /(\s*)while (.*)/){
        if ($2 eq 'true'){
            $line =~ s?while (.*)?while \(1\) {?;
        } elsif ($2 eq 'false') {
            $line =~ s?while (.*)?while \(0\) {?;
        }
    } 
    return $line;
}


# main
$index = 0;
while ($index <= $#file_line){
    my $line = $file_line[$index];

    # first line-token from lecture
    if ($line =~ /^#!.*/){
        $line =~ s?^#!.*?#!/usr/bin/perl -w?;
    }

    # ehco-token from lecture
    if ($line =~ /echo (.*)/){
        $line =echon($line);        
    }

    # if '=' in line
    if ($line =~ /(.*)=(.*)/){
        $line = equal($line);
    }

    #check ls
    if ($line =~ /^ls(.*)/){
        $line =~ s?^ls(.*)?system "ls$1";?;
    }
    #check pwd
    if ($line =~ /^pwd(.*)/){
        $line =~ s?^pwd(.*)?system "pwd$1";?;
    }
    #check id
    if ($line =~ /^id(.*)/){
        $line =~ s?^id(.*)?system "id$1";?;
    }
    #check date
    if ($line =~ /^date(.*)/){
        $line =~ s?^date(.*)?system "date$1";?;
    }
    #check cd
    if ($line =~ /^cd (.*)/){
        $line =~ s?^cd (.*)?chdir "$1";?;
    }
    #check read
    if ($line =~ /^\s*read (.*)/){
        $line =~ s?(.*)read (.*)?$1\$$2 = <STDIN>;\n$1chomp \$$2;?;
    }

    #check for loop
    if ($line =~ /^for (.*) in/){
        # $line = forloop(\@line);
    }

    #check if
    if ($line =~ /\s*if\s*(.*)/){
        $line = ifcheck($line);
    }
    #check then
    if ($line =~ /^\s*then\n/){
        $line = '';
    }
    #checn else
    if ($line =~ /(^\s*)else\n*/){
        $line =~ s?(^\s*)else\n*?$1} else {\n?;
    }
    if ($line =~ /^\s*fi\n*/){
        $line =~ s?fi?}?;
    }

    # check forloop
    if ($line =~ /\s*for (.*) in/){
        $line = forloop($line);
    }
    # check do
    if ($line =~ /^\s*do\n/){
        $line = '';
    }
    # check done
    if ($line =~ /^\s*done\n*/){
        $line =~ s?done?}?;
    }
    # check exit
    if ($line =~ /\s*exit (\d)/){
        $line =~ s?exit (\d)?exit $1;?;
    }

    #check while loop
    if ($line =~ /^\s*while /){
        $line = whileloop($line);
    }

    #check dollar signs.  eg: $1, $2, $@, $#, $*
    if ($line =~ /\$[0-9\@\#\*]/){
        $line = dollarsigns($line);
    }


    print "$line";
    $index++;
}