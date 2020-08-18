library(data.table)
library(ggplot2)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = 'DDX11L1_expression_data.csv', header = TRUE, sep=',')

# subset dat to specific tissue type
tissue <- dat[dat$tissue_type == 'Hippocampus'] # insert tissue type here
tf <- colnames(tissue[,2])
tf_format <- gsub("_", " ", tf)
tissue_type <- tissue[1,3]

# produce scatter plot
pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/', tf, "_", tissue_type, "scatter_plot.pdf"))
plot <- ggplot(tissue, aes(x=sample, y=DDX11L1_expression)) +
  geom_boxplot(colour = "red", fill= "orange", alpha = 0.5) +
  scale_x_discrete(labels = NULL) +
  theme( axis.text.y = element_text(angle = 90)) +
  ggtitle(paste0(tf_format, " in ", tissue_type, " tissue"))
print(plot)
dev.off()