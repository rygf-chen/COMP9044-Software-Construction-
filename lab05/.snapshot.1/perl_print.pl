#!/usr/bin/perl -w

print "#!/usr/bin/perl -w\n";
print "print \"";
foreach $content (split //, $ARGV[0]) {
    printf "\\x%02x", ord($content);
}
print "\\n\";\n";