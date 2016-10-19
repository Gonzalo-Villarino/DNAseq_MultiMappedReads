### DNAseq_MultiMappedReads
## I. reads must be mapped using bowtie for uniqly mapped 
     (1) $bowtie -q -S -m 1 -n 2

## II. Then
     (1) $bowtie -q -S -m 1 -n 2 --un unmapped.fastq, then for those unmapped read: 
     (2) $use bowtie -q -S -a -n 2 using unmapped.fastq as input

## III. 
     (1) run remove.unmapped.pl to remove unmapped reads from your multi-mapped file:
         $perl remove.unmapped.pl BW_Multi.Mapped_atxr56_8C.sam  -> BW_Multi.Mapped_atxr56_8C.filter.sam 
         (once .filter.sam is done, you may delete the original .sam as it takes too much space)
    
     (2) after removing unmapped reads, count how many times each individual read aligned to the genome: 
        $cut -f1 BW_Multi.Mapped_atxr56_8C.filter.sam | sort | uniq -c > BW_Multi.Mapped_atxr56_8C.filter.count
    
    
