# ============================
# 06_pathways_SPIA.R
# ============================

library(SPIA)
library(tidyverse)

res <- read.csv("results/DEG/DEG_IBD_vs_Healthy.csv")

sig <- res |> 
  filter(padj < 0.05) |> 
  pull(GeneID)

fc <- res$log2FoldChange
names(fc) <- res$GeneID

spia_res <- spia(de = fc, all = names(fc), organism = "hsa")

write.csv(as.data.frame(spia_res), "results/pathways/SPIA_results.csv", row.names = FALSE)
