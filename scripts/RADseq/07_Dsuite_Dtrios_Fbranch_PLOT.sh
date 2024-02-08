#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=cpu
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64G
#SBATCH --export=NONE
#SBATCH --job-name=Dtrios
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## DTRIOS

echo "Running Dtrios\n"

DSUITE=/users/djeffrie/Software/Dsuite/Build/Dsuite
VCF=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_NoHybs_or_singles_p30_r0.65_min_mac2/populations.snps.vcf
SETS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Dsuite/Sets_NoHybs_or_singles.txt
TREE=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Dsuite/Unpooled_NoSinges/phylo.io.nwk
DT_OUT=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Dsuite/Unpooled_NoSinges/DTRIOS_OUT

$DSUITE Dtrios -o $DT_OUT -t $TREE $VCF $SETS

## FBRANCH

echo "Running Fbranch\n"

FVALS=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Dsuite/Unpooled_NoSinges/DTRIOS_OUT_tree.txt
FB_OUT=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Dsuite/Unpooled_NoSinges/FBRANCH.out

$DSUITE Fbranch -p 0.01 $TREE $FVALS > $FB_OUT

## PLOT FBRANCH

echo "Plotting Fbranch\n"

module load gcc/9.3.0
module load python/3.8.8

DTOOLS=/users/djeffrie/Software/Dsuite/utils/dtools.py

python3 $DTOOLS $FB_OUT $TREE




