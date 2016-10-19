use strict;
use warnings;
##usage    perl cal.readscount.pl uniqmapp.sam multimap.sam  chrname chrsize

my $wsize = 1000;
my $overlap = 500;
my $chr = $ARGV[2];
my $chrsize = $ARGV[3];
my %pos;
my %end;
my $count = 0;
my %reads;
my $multicount = 0;

###load score of multiple mapped reads###
my $multi = $ARGV[1];
$multi =~ s/\.sam//;
open(FILE,"$multi.count") or die;
while(<FILE>){
    chomp;
    s/^ +//g;
    my @line = split(/ /,$_);
    $reads{$line[1]} = $line[0];
    $multicount = $multicount + 1;
}
close FILE;


open(FILE,$ARGV[0]) or die;
while(<FILE>){
        chomp;
        my @line = split(/\t/,$_);
        next if(/@/);
        my $len = length($line[9]);
        if($line[2] eq $chr){
            if(exists $pos{$line[3]}->{UNI}){
                    if(exists $end{$line[3]+$len}->{UNI}){
                        next;
                    }
                    else{
                        $pos{$line[3]}->{UNI} = $pos{$line[3]}->{UNI} + 1;
                        $end{$line[3]+$len}->{UNI} = 1;
                        $count++;
                    }
            }
            else{
                $pos{$line[3]}->{UNI} = 1;
                $end{$line[3]+$len}->{UNI} = 1;
                $count++;
            }
        }
 }
 close FILE;

open(FILE,$ARGV[1]) or die;
while(<FILE>){
        chomp;
        my @line = split(/\t/,$_);
        next if(/@/);
        my $len = length($line[9]);
        if($line[2] eq $chr){
            if(exists $pos{$line[3]}->{MULTI}){
                    if(exists $end{$line[3]+$len}->{MULTI}){
                        next;
                    }
                    else{
                        $pos{$line[3]}->{MULTI} = $pos{$line[3]}->{MULTI} + 1/$reads{$line[0]};
                        $end{$line[3]+$len}->{MULTI} = 1/$reads{$line[0]};
                        $count++;
                    }
            }
            else{
                $pos{$line[3]}->{MULTI} = 1/$reads{$line[0]};
                $end{$line[3]+$len}->{MULTI} = 1/$reads{$line[0]};
                $multicount++;
            }
        }
 }
 close FILE;




my $i = 1;
open(OUT,">$ARGV[0]\.$ARGV[2]\.count.txt") or die;
while($i<$chrsize+$wsize){
    my $j = $i;
    my $count = 0;
    my $mcount = 0;
    while($j<$i+$wsize){
        if(exists $pos{$j}->{UNI}){
            $count = $count + $pos{$j}->{UNI};
        }
	if(exists $pos{$j}->{MULTI}){
		$mcount = $mcount + $pos{$j}->{MULTI};
	}
        $j++;
    }
    print OUT "$j\t$count\t$mcount\n";
    $i = $i + $overlap;

}

close OUT;

print "$ARGV[2]\t$count\t$multicount\n";


           
