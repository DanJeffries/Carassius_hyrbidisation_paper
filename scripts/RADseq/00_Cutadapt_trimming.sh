#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=axiom
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --export=NONE
#SBATCH --array=1-246
#SBATCH --job-name=Cutadapt
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


module add UHTS/Quality_control/cutadapt/2.5;

## Set some directories 

DEMULTIPLEXED_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Demultiplexed_reformatted/
TRIMMED_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/1st_ends_trimmed/

## File containing a list of sample names to iterate over in the array. 

ITERFILE=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Demultiplexed/1stends.txt

SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p $ITERFILE)

cutadapt -l 92 -o $TRIMMED_DIR/$SAMPLE $DEMULTIPLEXED_DIR/$SAMPLE
