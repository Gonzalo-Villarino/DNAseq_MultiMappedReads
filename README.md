## DNAseq: Multi & Uniqly Mapped Reads using bowtie



## I. Generate Uniqly (1) & Multi (2) Mapped files
     (1) $bowtie -q -S -m 1 -n 2 --un unmapped.fastq, then for those unmapped read: 
     (2) $use bowtie -q -S -a -n 2 using unmapped.fastq as input

## III. Process and comined I and II
     (1) run remove.unmapped.pl to remove unmapped reads from your multi-mapped file:
         $perl remove.unmapped.pl BW_Multi.Mapped_atxr56_8C.sam  -> BW_Multi.Mapped_atxr56_8C.filter.sam 
          (once .filter.sam is done, you may delete the original MULTIMAPPED.sam as it takes too much space)
    
     (2) after removing unmapped reads, count how many times each individual read aligned to the genome: 
         $cut -f1 BW_Multi.Mapped_atxr56_8C.filter.sam | sort | uniq -c > BW_Multi.Mapped_atxr56_8C.filter.count
         
      (3) perl run.script.bash.pl BW_Uniqly.Mapped_atxr56_8C.sam BW_Multi.Mapped_atxr56_8C.filter.sam 
          (It will generate bash files for each chromosome so you can submit them into cluster using sbatch (SLURM) qsub (TORQUE) 
          it may take one day to get the result)
    
    
