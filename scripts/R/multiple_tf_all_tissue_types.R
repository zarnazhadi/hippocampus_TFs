library(data.table)
library(ggplot2)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = '10_TFs_expression_data.csv', header = TRUE, sep=',')

# boxplot for each tf
p <- lapply(names(dat)[2:11], function(x) {
  pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/all_tissue/', x, "_expression_log_scale_boxplot.pdf"))
  plot <- ggplot(dat, aes(x = tissue_type, y = dat[[x]] + 0.0000000001)) +
    scale_y_log10() +
    geom_boxplot(colour = "red", fill= "orange", alpha = 0.5) +
    theme( axis.text.x = element_text(angle = 90)) +
    ggtitle(paste0(x, " expression in all tissue types")) + ylab(paste0(x, " Expression (log10)"))
  print(plot)
  dev.off()
})

p
