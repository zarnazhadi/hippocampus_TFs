library(data.table)
library(ggplot2)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = 'DDX11L1_expression_data.csv', header = TRUE, sep=',')

# subset dat to specific tissue type
tissue <- dat[dat$`tissue type` == 'Hippocampus'] # insert tissue type here
tf <- colnames(tissue[,2])
tf_format <- gsub("_", " ", tf)
tissue_type <- tissue[1,3]

# produce scatter plot
pdf(paste0('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/plots/', tf, "_", tissue_type, "scatter_plot.pdf"))
plot <- ggplot(tissue, aes(x=sample, y=DDX11L1_expression)) +
  geom_point(colour = "red", fill= "orange", shape = 18) +
  theme( axis.text.y = element_text(angle = 90)) +
  ggtitle(paste0(tf_format, " in ", tissue_type, " tissue"))
print(plot)
dev.off()