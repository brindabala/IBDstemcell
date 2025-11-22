# ============================
# 05_inflammation.R
# ============================

library(tidyverse)

inflam <- load_gene_list("data/inflammation_genes.txt")
res <- read.csv("results/DEG/DEG_IBD_vs_Healthy.csv")

inflam_deg <- res[res$GeneID %in% inflam$GeneID, ]

write.csv(inflam_deg, "results/DEG/inflammation_DEGs.csv", row.names = FALSE)
