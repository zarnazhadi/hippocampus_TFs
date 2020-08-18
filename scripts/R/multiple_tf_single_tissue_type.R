library(data.table)
library(ggplot2)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = '10_TFs_expression_data.csv', header = TRUE, sep=',')

# subset dat to specific tissue type
tissue <- dat[dat$tissue_type == 'Hippocampus'] # insert tissue type here
tissue_type <- tissue[1,12]

# drop factors- not numeric
tissue$sample <- factor(tissue$sample)
tissue$tissue_type <- factor(tissue$tissue_type)
tissue %>% str()

# function to produce a graph for each tf in tissue df
p <- lapply(names(tissue)[2:11], function(x) {
  pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/hippocampus/', x, "_expression_", tissue_type, "_boxplot.pdf"))
  plot <- ggplot(tissue, aes(x = sample, y = tissue[[x]], group = 1)) + 
    geom_boxplot(colour = "red", fill= "orange", alpha = 0.5) + 
    scale_x_discrete(labels = NULL) +
    ggtitle(paste0(x, " expression in ", tissue_type, " tissue")) + ylab(paste0(x, " Expression"))
  print(plot)
  dev.off()
})

p
