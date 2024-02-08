#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=cpu
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=32G
#SBATCH --export=NONE
#SBATCH --job-name=VCFtools_HWE_stats
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err

module load gcc/9.3.0 
module load vcftools/0.1.14


VCF=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/populations.snps.vcf
OUT=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/populations.snps.coverage_filtered.vcf
#OUT_STATS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/populations.snps.HWEfiltered

KEPT_LOCI=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/Coverage_filtered_kept_loci.txt

vcftools --vcf $VCF --out $OUT --recode --recode-INFO-all --snps $KEPT_LOCI

