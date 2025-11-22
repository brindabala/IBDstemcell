# ============================
# 01_load_data.R
# ============================

library(tidyverse)

source("scripts/helpers.R")
create_dirs()

# Load raw counts
counts <- read.csv("data/counts_matrix.csv")

# Fix final column names
colnames(counts) <- c(
  "GeneID",
  "P12_1", "P12_2", "P12_3",
  "P12_4", "P12_5", "P12_6", "P12_7",
  "P89_1", "P89_2", "P89_3", "P89_4",
  "P90_1", "P90_2", "P90_3",
  "P99_1", "P99_2", "P99_3",
  "P99_4", "P99_5", "P99_6"
)

write.csv(counts, "data/counts_clean.csv", row.names = FALSE)
