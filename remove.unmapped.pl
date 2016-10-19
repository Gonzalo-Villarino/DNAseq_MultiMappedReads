use strict;
use warnings;

open(FILE,$ARGV[0]) or die;
while(<FILE>){
    chomp;
    next if(/@/);
    my @line = split(/\t/,$_);
    next if($line[1] == 4);
    print "$_\n";
}
close FILE;
