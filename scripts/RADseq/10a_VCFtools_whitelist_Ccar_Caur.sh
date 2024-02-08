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


VCF=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_Ccar_vs_Caur_p3_r0.9_min_mac2/populations.snps.vcf
KEEP_LOCI=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/NewHybrids/Fixed_whitelist_Ccar_Caur.txt
OUT=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_Ccar_vs_Caur_p3_r0.9_min_mac2/populations_Fixed_snps_maxcov40.vcf

vcftools --vcf $VCF --out $OUT --recode --recode-INFO-all  --max-meanDP 40 --snps $KEEP_LOCI

