### Converting Fbranch Z-scores to p-values

# Z scores are simply the number of standard deviations from the mean. 
# To convert to a p-value you just need to draw the the normal distribution and find the position in that distribution of a given value . . . 
# The area under the curve towards the high tail of the distribution then tells you how how likely a value is to be that large or higher. 

# In this case our values represent allele sharing, so a p-value represents the probability that a trio shows that much allele sharing or higher. 

# high values in the N. EU crucian. # This makes me think though, that the extremely high values in the dataset are going to influence our p-value - so I might have to get rid of the 

setwd("/home/djeffrie/Data/Crucian/Dsuite/New/")

df <- read.delim("Z_scores_matrixonly.txt", na.strings = "NaN")

install.packages("Kmisc")
library(reshape2)

melted_z_scores <- melt(df) ## make single vector of all z-scores

hist(melted_z_scores[,2], 50) # plt just z-scores 

hist(pnorm(melted_z_scores[,2]), 50)

pvals = data.frame(column=melted_z_scores[,1], pval=1-pnorm(melted_z_scores[,2]))

write.table(pvals, "pvalues.txt", quote = F, sep = "\t", row.names = F) ## I un-melted this in bash: `for i in $(cat pops.tmp ); do echo $i > pop_pvals/${i}.txt; grep $i pvalues.txt | cut -f2 >> pop_pvals/${i}.txt; done`

pval_df <- read.delim("Pvalues.txt", na.strings = "NA")

str(pval_df)


pval_mat <- data.matrix(pval_df[,c(1,3:21,23:34)]) # create numerical matrix with only data columns 

str(pval_mat)

rownames(pval_mat) <- pval_df$branch

colnames(pval_mat) ## check "Outgroup" is not there - this has only NAs and causes issues

pval_mat[,1] <- rep(0.5, length(pval_mat[,1]))


heatmap(pval_mat, ) ## plot heatmap of p-vals


colSums(pval_mat,na.rm = T)
rowSums(pval_mat,na.rm = T)

names(pval_df)

str(pval_mat)

melted_Pvals <- melt(pval_df[,c(1,3:34)], id.vars = "branch")

melted_Pvals[melted_Pvals$value<=0.01,]



                   