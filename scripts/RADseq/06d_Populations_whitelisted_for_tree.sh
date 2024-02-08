#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=124G
#SBATCH --export=NONE
#SBATCH --job-name=Pop_All
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


module load gcc/9.3.0
module load stacks/2.53

## Set some directories 

STACKS_DIR=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks
POPMAP=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian//Dsuite/Sets_pure_only.txt
WHITELIST=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian//Stacks/Populations_ALL_p7_r0.65_min_mac2/whitelist.txt

pops=""
prop=""
other="whitelist_for_spp_tree"

OUTDIR=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_${other}

mkdir $OUTDIR

## Load in Stacks

populations -P $STACKS_DIR -M $POPMAP -W $WHITELIST -O $OUTDIR --vcf --phylip
