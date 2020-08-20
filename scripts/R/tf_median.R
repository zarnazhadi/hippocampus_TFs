library(data.table)
library(ggplot2)
library(dplyr)
library(tidyverse)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = '10_TFs_expression_data.csv', header = TRUE, sep=',')

dat <- dat[,-1]

medians <- as.data.frame(dat %>% group_by(tissue_type) %>% summarise_all(funs(median)))
colnames <- colnames(medians)
rownames(medians) <- medians$tissue_type
medians <- medians[,-1]
medians <- as.data.frame(t(medians))

for(col in 1:length(medians)){
  medians_subset <- as.data.frame(medians[,col])
  colnames(medians_subset) <- c(colnames(medians)[col])
  #medians_subset$order = order(medians_subset)
  medians_subset$rank = rank(medians_subset)
  print(medians_subset)
}


