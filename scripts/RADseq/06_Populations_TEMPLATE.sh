#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=axiom
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --export=NONE
#SBATCH --job-name=Pop_All
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## Set some directories 

STACKS_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks
POPMAP=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/Pure_for_ABBA_BABA.txt

pops=4
prop=0.6

OUTDIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/Populations_ALL_p${pops}_r${prop}

mkdir $OUTDIR



## Load in Stacks

module load UHTS/Analysis/stacks/2.3e

populations -P $STACKS_DIR -M $POPMAP -r $prop -p $pops -O $OUTDIR --vcf
