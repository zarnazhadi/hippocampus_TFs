library(data.table)
library(ggplot2)
# library(tidyr)
library(tidyverse)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = '10_TFs_expression_data.csv', header = TRUE, sep=',')

# subset dat to specific tissue type
tissue <- dat[dat$tissue_type == 'Hippocampus'] # insert tissue type here
tissue_type <- tissue[1,12]

# drop factors- not numeric
tissue$sample <- factor(tissue$sample)
tissue$tissue_type <- factor(tissue$tissue_type)
tissue %>% str()

tfs <- names(tissue)[2:11]
for(tf in tfs){
  pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/', tf, "_expression_", tissue_type, "scatter_plot.pdf"))
  tissue_subset <- subset(tissue, select=c('sample', tf))
  plot <- ggplot(tissue_subset, aes(x=sample, y=tf)) +
    geom_boxplot(colour = "red", fill= "orange", alpha = 0.5) +
    theme(axis.text.y = element_text(angle = 90)) +
    ggtitle(paste0(tf, " expression in ", tissue_type, " tissue"))
  print(plot)
  dev.off()
}
