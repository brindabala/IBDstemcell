# ============================
# 07_deconvolution.R
# ============================

library(immunedeconv)
library(tidyverse)

mat <- read.csv("data/counts_clean.csv")
rownames(mat) <- mat$GeneID
mat <- mat[ , -1]

results <- deconvolute(mat, method = "epic")

write.csv(results, "results/deconvolution/epic_results.csv", row.names = FALSE)
