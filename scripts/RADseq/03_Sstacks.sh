#!/bin/bash

#SBATCH --account=nperrin_rana_genome
#SBATCH --partition=axiom
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --export=NONE
#SBATCH --array=117
#SBATCH --job-name=Sstacks
#SBATCH --output=%x_%A-%a.out
#SBATCH --error=%x_%A-%a.err


## Set some directories 

STACKS_DIR=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/

## File containing a list of sample names to iterate over in the array. 

ITERFILE=/scratch/axiom/FAC/FBM/DEE/nperrin/rana_genome/Crucian/Stacks/samples_sstacks.txt

SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p $ITERFILE)  ## Use a sed one-liner and the SLURM_ARRAY_TASK_ID to get the appropriate line in the $ITERFILE

## Load in Stacks

module load UHTS/Analysis/stacks/2.3e

echo "sstacks -c ${STACKS_DIR} -s ${STACKS_DIR}/${SAMPLE} -o $STACKS_DIR -p 4"

sstacks -c ${STACKS_DIR} -s ${STACKS_DIR}/${SAMPLE} -o $STACKS_DIR -p 4

