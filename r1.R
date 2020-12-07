## load package
library(readr)
library(dplyr)
library(magrittr)
library(tximport)
library(DESeq2)
library(tidyverse)

## not a data.frame but tibble

sample_table = read_csv("SraRunTable.txt") %>% 
  select(`Sample Name`, source_name, TREATMENT,
         Cell_Line,  Cell_type, Time_point) %>%
  slice(c(3,4,13,15))
sample_table = read_csv("SraRunTable.txt")
sample_table = select(sample_table,`Sample Name`, source_name, TREATMENT,
                      Cell_Line,  Cell_type, Time_point)
sample_table = unique(sample_table)
sample_table = slice(sample_table, seq(1,16, by =4))

sample_file = paste0(pull(sample_table,`Sample Name` ), '/quant.sf')

names(sample_file) = 
  pull(sample_table,`Sample Name` )

sample_file[1]
gene_map = read_csv("gene_map.csv", col_names = c('enstid', 'ensgid'))

count_data = tximport(files = sample_file,
                      type = "salmon",
                      tx2gene =gene_map,
                      ignoreTxVersion = TRUE)
