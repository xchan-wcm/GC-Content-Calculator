# GC-Content-Calculator

## This script calculates GC content percentage for non-overlapping genome bins of a specified size using bedtools and converts the resulting bedgraph file to bigWig format. The input genome sequence file (in fasta format) and its associated index file (in fai format) are required.

The script first generates the genome bins using bedtools makewindows command, and then calculates GC content percentage for each bin using bedtools nuc command and awk. The resulting bedgraph file is sorted numerically by chromosome and genomic position using LC_COLLATE=C to ensure correct sorting order, and then converted to bigWig format using bedGraphToBigWig.

The output files include the genome bin bed file (hg19_50bp_bins.bed), the GC content bedgraph file (hg19_50bp_gc_percent.bedgraph), the sorted GC content bedgraph file (sorted_hg19_50bp_gc_percent.bedgraph), and the final bigWig file (hg19_50bp_gc_percent.bw). Intermediate files are removed at the end of the script.

This script can be modified to change the genome bin size and the input/output file paths.
