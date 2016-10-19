use strict;
use warnings;
my $file = $ARGV[0];
my $multifile = $ARGV[1];
my $dir = "/home3/rnaseq-shared/Gonzalo/Yannick/02_NewApprocah/mapped/";

open(FILE,"chr.size.txt") or die;
while(<FILE>){
    chomp;
    my @line = split(/ /,$_);
    open(OUT,">$ARGV[0].$line[0].bash") or die;
    print OUT "#!/bin/bash\n";
    print OUT "perl /home3/rnaseq-shared/Gonzalo/Yannick/02_NewApprocah/mapped/cal.readscount.v2.pl $dir$ARGV[0] $dir$ARGV[1] $line[0] $line[1] >> $ARGV[0].lib.count\n";
}
close FILE;
