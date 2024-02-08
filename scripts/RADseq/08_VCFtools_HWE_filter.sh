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
OUT=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/populations.snps.HWEfiltered.vcf
#OUT_STATS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/populations.snps.HWEfiltered

POPMAP=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/Popmap_pure.txt
LARGE_PURE_POPS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/Large_pops.txt

#for POP in $(cat $LARGE_PURE_POPS);
#do
#	echo $POP
#	KEPT_INDIVs=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/VCFtools_kept_lists/${POP}.txt
#	INITIAL_STATS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/VCFtools_STATS/${POP}.snps
#
#    	grep $POP $POPMAP | cut -f1 > $KEPT_INDIVs
#
#
#	vcftools --vcf $VCF --freq --out $INITIAL_STATS --keep $KEPT_INDIVs
#	vcftools --vcf $VCF --hardy --out $INITIAL_STATS --keep $KEPT_INDIVs
#	vcftools --vcf $VCF --het --out $INITIAL_STATS --keep $KEPT_INDIVs
#
#
#done

vcftools --vcf $VCF --site-mean-depth --out /work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p7_r0.65_min_mac2_spp/VCFtools_STATS/All_pure_mean_covs --keep $POPMAP


#vcftools --vcf $VCF \
#         --hwe \
#	 --recode \
#	 --recode-INFO-all \
#         --out $OUT

#vcftools --vcf $OUT \
#         --freq \
#	 --out $OUT_STATS
