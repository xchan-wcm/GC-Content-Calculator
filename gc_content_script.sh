#!/bin/bash

# Define input and output file paths
genome_fasta="hg19.fa"
genome_fai="hg19.fa.fai"
bin_size=50
output_bed="hg19_${bin_size}bp_bins.bed"
output_bedgraph="hg19_${bin_size}bp_gc_percent.bedgraph"
output_sorted_bedgraph="sorted_hg19_${bin_size}bp_gc_percent.bedgraph"
output_bigwig="hg19_${bin_size}bp_gc_percent.bw"

# Create genome bins using bedtools makewindows
bedtools makewindows -g ${genome_fai} -w ${bin_size} > ${output_bed}

# Calculate GC content for each bin using bedtools nuc and awk
bedtools nuc -fi ${genome_fasta} -bed ${output_bed} -seq | awk 'OFS="\t" {print $1, $2, $3, $5 }' > ${output_bedgraph}

# Remove the first row of the bedgraph file
tail -n +2 ${output_bedgraph} > tmp && mv tmp ${output_bedgraph}

# Sort the bedgraph file using LC_COLLATE=C to ensure numerical sorting of chromosomes
LC_COLLATE=C sort -k1,1 -k2,2n ${output_bedgraph} > ${output_sorted_bedgraph}

# Convert the sorted bedgraph file to bigWig format using bedGraphToBigWig
bedGraphToBigWig ${output_sorted_bedgraph} ${genome_fai} ${output_bigwig}

# Remove intermediate files
rm ${output_bedgraph} ${output_sorted_bedgraph}
