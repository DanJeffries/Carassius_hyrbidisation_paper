#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=axiom
#SBATCH --time=3-00:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --export=NONE
#SBATCH --job-name=Catalog
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## Set some directories 

STACKS_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks
POPMAP=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/Popmap_Cstacks.txt

## Load in Stacks

module load UHTS/Analysis/stacks/2.3e

cstacks -P $STACKS_DIR -M $POPMAP -n 4 -p 8
