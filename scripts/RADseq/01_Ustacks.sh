#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=axiom
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --export=NONE
#SBATCH --array=117
#SBATCH --job-name=Ustacks
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## Set some directories 

DEMULTIPLEXED_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/1st_ends_trimmed/
STACKS_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/

## File containing a list of sample names to iterate over in the array. 

ITERFILE=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Scripts/Popmaps/samples.txt

SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p $ITERFILE)  ## Use a sed one-liner and the SLURM_ARRAY_TASK_ID to get the appropriate line in the $ITERFILE

## Load in Stacks

module load UHTS/Analysis/stacks/2.3e


ustacks -f ${DEMULTIPLEXED_DIR}/${SAMPLE} -i $SLURM_ARRAY_TASK_ID -o $STACKS_DIR -M 4 -m 6 -p 4 -d   ## pass all the bash variables we have made to Ustacks. 

