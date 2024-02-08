#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=124G
#SBATCH --export=NONE
#SBATCH --job-name=Ccar_caur
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


module load gcc/9.3.0
module load stacks/2.53

## Set some directories 

STACKS_DIR=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks
POPMAP=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/NewHybrids/Ccar_vs_Caur_popmap.txt

WHITELIST=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/NewHybrids/Ccar_Caur_AMOVAFst_0.9_whitelist.txt

OUTDIR=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_Ccar_vs_Caur_Whitelisted_Fst_095/

mkdir $OUTDIR

## Load in Stacks

populations -P $STACKS_DIR -M $POPMAP -W $WHITELIST -O $OUTDIR --vcf --phylip --min-mac 2 --radpainter --fstats
