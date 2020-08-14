library(data.table)
library(ggplot2)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = 'DDX11L1_expression_data.csv', header = TRUE, sep=',')

# formatting
tf <- colnames(dat[,2])
tf_format <- gsub("_", " ", tf)

# produce scatter plot
pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/', tf, "_all_tissue_types_boxplot.pdf"))
plot <- ggplot(dat, aes(x=tissue_type, y=DDX11L1_expression + 0.0000000001, colour = tissue_type)) + scale_y_log10() +
  geom_boxplot(colour = "red", fill= "orange", alpha = 0.5) + 
  theme( axis.text.x = element_text(angle = 90)) +
  ggtitle(paste0(tf_format, " in all tissue types"))
print(plot)
dev.off()