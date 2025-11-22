# ============================
# 02_prepare_metadata.R
# ============================

library(tidyverse)

counts <- read.csv("data/counts_clean.csv")

samples <- colnames(counts)[-1]

metadata <- tibble(
  sample = samples,
  patient = sub("_[0-9]+$", "", samples),
  replicate = as.numeric(sub(".*_", "", samples)),
  condition = ifelse(grepl("P12", samples), "Healthy", "IBD")
)

metadata$condition <- factor(metadata$condition, levels = c("Healthy", "IBD"))

write.csv(metadata, "data/sample_metadata.csv", row.names = FALSE)
