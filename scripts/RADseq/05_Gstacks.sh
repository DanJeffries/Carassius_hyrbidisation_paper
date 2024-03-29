#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=128G
#SBATCH --export=NONE
#SBATCH --job-name=Gstacks
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## Set some directories 

STACKS_DIR=/work/FAC/FBM/DEE//nperrin/rana_genome/Crucian/Stacks/
POPMAP=/work/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/Popmap_Cstacks.txt

## Load in Stacks

module load gcc/9.3.0
module load stacks/2.53


gstacks -P $STACKS_DIR -M $POPMAP -t 8
