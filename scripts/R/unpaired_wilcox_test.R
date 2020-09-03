library(data.table)
library(dplyr)

# import exp data
dat = fread("/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/10_TFs_expression_data.csv", header = TRUE, sep= ',')
dat <- dat[, -c(1)] # remove sample column

# column names and row names for pvalues df
tfs <- colnames(dat)[-11]
tissues <- unique(dat$tissue_type) 

# pvalues matrix
pvalues <-  matrix(0, 13,10)

row <- 0 # row count

for(col in 1:length(dat[,-11])){
  # subset by tf
  subset <- dat %>% select(col, 11)
  tf <- colnames(subset)[1]
  
  # subset tf by hippocampus only
  hippocampus <- as.matrix(subset(subset,  tissue_type == "Hippocampus", tf,
                                  drop = TRUE))
  for(tissue in tissues){
    row <- row + 1
    
    # subset tf by each tissue
    t <- as.matrix(subset(subset,  tissue_type == tissue, tf,
                                   drop = TRUE))
    
    # unpaired wilcox test- compare hippocampus and other tissue
    p <- wilcox.test(hippocampus, t)$p.value
    # add p to matrix
    pvalues[row, col] = pvalues[row, col] + p
  }
  row <- 0 # reset for new loop
}

# matrix to df
pvalues <- as.data.frame(pvalues)
colnames(pvalues) <- tfs
pvalues <- pvalues[-9,] # remove hippocampus row

# filter to p values which reject null hyp
reject <- as.data.frame(sapply(pvalues, function(x) ifelse(x<0.05, x, NA)))
row.names(reject) <- tissues[-9]

# summary- returns error
reject %>% summarise_all(funs(min, max), na.rm =TRUE)
