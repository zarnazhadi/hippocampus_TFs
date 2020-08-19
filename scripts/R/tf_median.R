library(data.table)
library(ggplot2)
library(dplyr)
library(tidyverse)

setwd('/Users/zarnazhadi/Desktop/hippocampus_TFs/expression_data/')
dat <- fread(file = '10_TFs_expression_data.csv', header = TRUE, sep=',')

tissue_types <- unique(dat$tissue_type)
median_list <-  list()
cols <- list()

for (x in 1:length(tissue_types)){
  tissue <- dat[dat$tissue_type == tissue_types[x]]
  median <- apply(tissue[,2:11], 2, median)

  cols[x] <- tissue_types[x]
  median_list[[x]] <- median
}

dat <- dat[,-1]

medians <- as.data.frame(dat %>% group_by(tissue_type) %>% summarise_all(funs(median)))
colnames <- colnames(medians)

apply(medians, 1, order)

