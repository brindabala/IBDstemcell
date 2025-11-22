# ============================
# 03_DESeq2_DEG.R
# ============================

library(dplyr)
library(DESeq2)
library(tidyverse)
library(EnhancedVolcano)

counts <- read.csv("data/counts_clean.csv")
metadata <- read.csv("data/sample_metadata.csv")

#Summarise data to average gene duplicates data so they can be set as rownames
counts <- counts %>% group_by(GeneID) %>% summarise(across(everything(), sum))
rownames <- counts$GeneID

counts <- as.matrix(counts[ , -1])
rownames(counts) <- rownames

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ condition
)

dds <- dds[rowSums(counts) > 10, ]  # basic filter

dds <- DESeq(dds)

res <- results(dds, contrast = c("condition", "IBD", "Healthy"))
res_df <- as.data.frame(res)
res_df$GeneID <- rownames(res_df)

write.csv(res_df, "results/DEG/DEG_IBD_vs_Healthy.csv", row.names = FALSE)

# volcano
png("results/DEG/volcano_IBD_vs_Healthy.png", width = 1200, height = 1000)
EnhancedVolcano(
  res_df,
  lab = res_df$GeneID,
  x = "log2FoldChange",
  y = "pvalue",
  title = "IBD vs Healthy",
  pCutoff = 0.05,
  FCcutoff = 1
)
dev.off()
