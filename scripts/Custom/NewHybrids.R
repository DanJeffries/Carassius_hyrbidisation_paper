library(parallelnewhybrid)

### First, from the pairwise 'Populations' (Stacks) runs, isolate the SNPs with 
### Fst > 0.9 between CAR and AUR and between CAR and GIB for the two NewHybrids analyses.


setwd("/home/djeffrie/Data/Crucian/NewHybrids/")

### CAR vs AUR

CAR_AUR_stats <- read.table("Ccar_Caur/populations.fst_CAR-AUR.tsv", 
                            header = T)
head(CAR_AUR_stats)
CAR_AUR_fst <- data.frame(Tag=CAR_AUR_stats$Locus_ID,Column=CAR_AUR_stats$Column+1, Fst=CAR_AUR_stats$AMOVA_Fst) ## note the +1 for the SNP column - there myst be a bug in Stacks which means it uses 0-based counting somewhere.

head(CAR_AUR_fst)

hist(CAR_AUR_fst$Fst, breaks = 100, 
     main = "C. carassius / C. auratus Fst", 
     xlab = "Fst",
     ylab = "N loci")

abline(v=0.95)

## There are a lot of loci with Fst = 1, so I will take these. 

CAR_AUR_FIXED <- CAR_AUR_fst[CAR_AUR_fst$Fst == 1,]

length(CAR_AUR_FIXED$Tag)

write.table(CAR_AUR_FIXED, "Ccar_Caur/AMOVAFst_1_loci.txt", col.names = T, row.names = F, quote = F)

## 8583 loci with Fst > 0.9 between C. carassius and C. auratus. 

### CAR vs GIB

CAR_GIB_stats <- read.table("Ccar_Cgib/populations.fst_CAR-GIB.tsv", 
                            header = T)

CAR_GIB_fst <- data.frame(Tag=CAR_GIB_stats$Locus_ID, Column=CAR_GIB_stats$Column+1, Fst=CAR_GIB_stats$AMOVA_Fst)

hist(CAR_GIB_fst$Fst, breaks = 100, 
     main = "C. carassius / C. gibelio Fst", 
     xlab = "Fst",
     ylab = "N loci")

abline(v=0.98)

## Getting fixed loci

CAR_GIB_FIXED <- CAR_GIB_fst[CAR_GIB_fst$Fst == 1,]

head(CAR_GIB_FIXED)

length(CAR_GIB_FIXED$Tag)

write.table(CAR_GIB_FIXED, "Ccar_Cgib/AMOVAFst_1_loci.txt", col.names = F, row.names = F, quote = F)

## 4460 loci with Fst > 0.95 between C. carassius and C. gibelio. 

## CAR vs CCARP ## 

CAR_CARP_stats <- read.table("Ccar_Ccarp/populations.fst_CAR-CARP.tsv",
                             header = T)

CAR_CARP_fst <- data.frame(Tag=CAR_CARP_stats$Locus_ID, Column=CAR_CARP_stats$Column+1, Fst=CAR_CARP_stats$AMOVA_Fst)

hist(CAR_CARP_fst$Fst, breaks = 100,
     main = "C. carassius / C. carpio Fst",
     xlab = "Fst",
     ylab = "N_loci")


## Getting fixed loci

CAR_CARP_FIXED <- CAR_CARP_fst[CAR_CARP_fst$Fst == 1,]

length(CAR_CARP_FIXED$Tag)


write.table(CAR_CARP_FIXED, "Ccar_Ccarp/AMOVAFst_1_loci.txt", col.names = F, row.names = F, quote = F)

## I filtered the pairwise VCFs for these fixed loci (and for max coverage of 40x) 
## and then converted to NH format with a custom python script. 


##############################
######## NEWHYBRIDS ##########
####### CCAR X CAUR ##########
#############################

NH_path <- "/home/djeffrie/Programs/newhybrids/"
Ccar_Caur_input_path = "/home/djeffrie/Data/Crucian/NewHybrids/Ccar_Caur/NH_wd/"

parallelnh_LINUX(folder.data = Ccar_Caur_input_path, where.NH = NH_path, burnin = 10, sweeps = 30)


##############################
######## NEWHYBRIDS ##########
####### CCAR X CGIB ##########
#############################

NH_path <- "/home/djeffrie/Programs/newhybrids/"
Ccar_Cgib_input_path = "/home/djeffrie/Data/Crucian/NewHybrids/Ccar_Cgib//NH_wd/"

parallelnh_LINUX(folder.data = Ccar_Cgib_input_path, where.NH = NH_path, burnin = 10, sweeps = 30)


##############################
######## NEWHYBRIDS ##########
####### CCAR X CCARP ##########
#############################

NH_path <- "/home/djeffrie/Programs/newhybrids/"
Ccar_Ccarp_input_path = "/home/djeffrie/Data/Crucian/NewHybrids/Ccar_Ccarp/NH_wd/"

parallelnh_LINUX(folder.data = Ccar_Ccarp_input_path, where.NH = NH_path, burnin = 10, sweeps = 30)


## Gave the individual data to the working directory as a file called "SimPops_S1R1_NH_individuals.txt"
write.table(x = sim_inds, file = paste0(path.hold, "/SimPops_S1R1_NH_individuals.txt"), row.names = FALSE, col.names = FALSE, quote = FALSE)

## Save the genotype data to the working directory as a file called "SimPops_S1R1_NH.txt"
write.table(x = sim_data, file = paste0(path.hold, "/SimPops_S1R1_NH.txt"), row.names = FALSE, col.names = FALSE, quote = FALSE)

## Create an empty folder within the working directory. Recall, parallelnewhybrids will analyze all files within the folder it is specified, but if there are files that are not NewHybrids format, or individual files, it will fail.
dir.create(paste0(path.hold, "/parallelnewhybrids example"))

## Copy the individual file to the new folder
file.copy(from = paste0(path.hold, "/SimPops_S1R1_NH_individuals.txt"), to = paste0(path.hold, "/parallelnewhybrids example"))

## Copy the genotype data file to the new folder
file.copy(from = paste0(path.hold, "/SimPops_S1R1_NH.txt"), to = paste0(path.hold, "/parallelnewhybrids example"))

## Create two copies of the genotype data file to act as technical replicates of the NewHybrids simulation based analysis. This will also serve demonstrate the parallel capabilities of parallelnewhybrid.
file.copy(from = paste0(path.hold, "/parallelnewhybrids example/SimPops_S1R1_NH.txt"), to = paste0(path.hold, "/parallelnewhybrids example/SimPops_S1R2_NH.txt"))

file.copy(from = paste0(path.hold, "/parallelnewhybrids example/SimPops_S1R1_NH.txt"), to = paste0(path.hold, "/parallelnewhybrids example/SimPops_S2R3_NH.txt"))

## Clean up the working directory by deleting the two files
file.remove(paste0(path.hold, "/SimPops_S1R1_NH_individuals.txt"))

file.remove(paste0(path.hold, "/SimPops_S1R1_NH.txt"))

## Create an object that is the file path to the folder in which NewHybrids is installed. Note: this folder must be named "newhybrids"
your.NH <- "YOUR PATH/newhybrids/"

## Execute parallelnh. NOTE: "xx" must be replaced by the correct designation for your operating system. burnin and sweep values have been chosen for demonstration only.
parallelnh_LINUX(folder.data = paste0(path.hold, "/parallelnewhybrids example/"), where.NH = NH_path, burnin = 100, sweeps = 100)


## Clean up everything by deleting the example folder. Note: comment characters have been added to prevent this command being run accidently.
unlink(paste0(path.hold, "/parallelnewhybrids example/"), recursive = TRUE)


## Create an object that is the file path to the folder in which NewHybrids is installed. Note: this folder must be named "newhybrids"
your.NH <- "YOUR PATH/newhybrids/"


###########################################
##########################################
####### Plotting posterior probs #########
##########################################
#########################################

library(reshape2)
library(ggplot2)
library(ggpubr)

#######################################
######## MICROSATS  ##################
######################################

## Microsat NH analyses were run using a GUI on a super old Mac, so I import the post probs from those analyses

MicroPPs <- read.delim("/home/djeffrie/Dropbox/PhD/Dans_PhD_Shared/Papers/Hybridisation paper/Data_files/MICRO_NH_post_probs.csv")

head(MicroPPs)
MicroPPs$RAD <- NULL
MicroPPs$MICRO <- NULL

## Chopping up as there are too many samples to 
## plot side by side

length(MicroPPs$CA)
MicroPPs$Combined_samples[c(1:227)]
MicroPPs$Combined_samples[c(228:448)]
MicroPPs$Combined_samples[c(449:673)]
MicroPPs$Combined_samples[c(674:908)]
MicroPPs$Combined_samples[c(909:1130)]
MicroPPs$Combined_samples[c(1130:1332)]

MicroPPs_melted_1 <- melt(MicroPPs[c(1:227),], variable.name = "Class", value.name = "Posterior_probability")
MicroPPs_melted_2 <- melt(MicroPPs[c(228:448),], variable.name = "Class", value.name = "Posterior_probability")
MicroPPs_melted_3 <- melt(MicroPPs[c(449:673),], variable.name = "Class", value.name = "Posterior_probability")
MicroPPs_melted_4 <- melt(MicroPPs[c(674:908),], variable.name = "Class", value.name = "Posterior_probability")
MicroPPs_melted_5 <- melt(MicroPPs[c(909:1130),], variable.name = "Class", value.name = "Posterior_probability")
MicroPPs_melted_6 <- melt(MicroPPs[c(1130:1332),], variable.name = "Class", value.name = "Posterior_probability")

head(MicroPPs_melted_1$`Posterior probability`)

## Spp. colours -----------

levels(MicroPPs_melted$Class)

RADspp.cols <- c(CA = "deepskyblue3",
                 AU = "firebrick4",
                 CA_AU_F1 = "darkorchid4",
                 CA_AU_F2 = "darkorchid",
                 CA_AU_BKX1 = "darkorchid1",
                 CA_AU_BKX2 = "darkorchid1", 
                 GI = "darkgreen",
                 CA_GI_F1 = "turquoise",
                 CA_GI_F2 = "turquoise4",
                 CA_GI_BKX1 = "turquoise1",
                 CA_GI_BKX2 = "turquoise1",
                 CY = "black", 
                 CA_CY_F1 = "grey25",
                 CA_CY_F2 = "grey50",
                 CA_CY_BKX1 = "grey75",
                 CA_CY_BKX2 = "grey75")


MICROspp.cols <- c(CA = "deepskyblue3",
              AU.spp. = "chocolate4",
              CY = "black",
              CA.x.AU.spp..F1 = "orange3",
              CA.x.AU.spp..F2 = "orange1",
              CA.x.AU.spp..BKX1 = "darkgoldenrod1",
              CA.x.AU.spp..BKX2 = "darkgoldenrod1",
              CA.x.CY.spp..F1 = "grey25",
              CA.x.CY.spp..F2 = "grey50",
              CA.x.CY.BKX.1 = "grey75",
              CA.x.CY.BKX2 = "grey75")


M1 <- ggplot(MicroPPs_melted_1, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  ylab("Posterior probability") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(legend.title = element_blank()) + 
  theme(legend.text = element_text(size = 8, family = "Times")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(size = 10, family = "Times")) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


M2 <- ggplot(MicroPPs_melted_2, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")

M3 <- ggplot(MicroPPs_melted_3, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")

M4 <- ggplot(MicroPPs_melted_4, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")

M5 <- ggplot(MicroPPs_melted_5, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")


M6 <- ggplot(MicroPPs_melted_6, aes(fill=Class, y=Posterior_probability, x=Combined_samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = MICROspp.cols) + 
  theme(axis.text.x = element_text(size=2, angle=45, hjust = 1.25, vjust = 2.25, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")

all <- ggarrange(M1, M2, M3, 
          M4, M5, M6, 
          ncol = 1, nrow = 6)

ggsave("~/Dropbox/PhD/Dans_PhD_Shared/Papers/Hybridisation paper/Figures/Misc/MICRO_posprobs.pdf",
       all, width = 196, height = 292,units = "mm" )


##############################
###### RADseq post probs #####
##############################

RADPPs <- read.delim("/home/djeffrie/Dropbox/PhD/Dans_PhD_Shared/Papers/Hybridisation paper/Data_files/RAD_NH_post_probs.csv")

RADspp.cols <- c(CA = "deepskyblue3",
                 AU = "firebrick4",
                 CA_AU_F1 = "darkorchid4",
                 GI = "darkgreen",
                 CA_GI_F1 = "chartreuse3",
                 CY = "black", 
                 CA_CY_F1 = "grey50")
  
  
RADPPs_melted_1 <- melt(RADPPs[c(1:130),], variable.name = "Class")
RADPPs_melted_2 <- melt(RADPPs[c(130:250),], variable.name = "Class")

head(RADPPs_melted_1)

RAD1 <- ggplot(RADPPs_melted_1, aes(fill=Class, y=value, x=Samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = RADspp.cols) + 
  ylab("Posterior probability") +
  theme(axis.text.x = element_text(size=4, angle=45, hjust = 1.25, vjust = 1.5, family = "Times")) +
  theme(legend.key.size = unit(0.25, 'cm')) + 
  theme(legend.title = element_blank()) +
  theme(legend.text = element_text(size = 8, family = "Times")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(size = 10, family = "Times")) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

RAD2 <- ggplot(RADPPs_melted_2, aes(fill=Class, y=value, x=Samples)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = RADspp.cols) + 
  theme(axis.text.x = element_text(size=4, angle=45, hjust = 1.25, vjust = 1.5, family = "Times")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.ticks = element_blank()) + 
  theme(axis.text.y = element_text(size = 8, family = "Times")) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.position = "none")


RADall <- ggarrange(RAD1, RAD2, 
                 ncol = 1, nrow = 2)

ggsave("~/Dropbox/PhD/Dans_PhD_Shared/Papers/Hybridisation paper/Figures/Misc/RAD_posprobs.pdf",
       RADall, width = 196, height = 100,units = "mm" )
