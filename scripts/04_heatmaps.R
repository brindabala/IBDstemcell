# ============================
# 04_heatmaps.R (updated)
# ============================

library(tidyverse)
library(pheatmap)

source("scripts/helpers.R")

counts <- read.csv("data/counts_clean.csv")
metadata <- read.csv("data/sample_metadata.csv")

rownames(counts) <- counts$GeneID
mat <- counts[ , -1]

# Load UC/CD cluster CSVs
uc_clusters <- read.csv("data/UC_cluster_genes.csv", check.names = FALSE)
cd_clusters <- read.csv("data/CD_clusters_genes.csv", check.names = FALSE)

# Convert each cluster column into a gene vector (remove empty cells, NA)
uc_cluster_lists <- lapply(uc_clusters, function(col) col[!is.na(col) & col != ""])
cd_cluster_lists <- lapply(cd_clusters, function(col) col[!is.na(col) & col != ""])

# Intersect each cluster with available genes
uc_cluster_lists <- lapply(uc_cluster_lists, function(g) safe_intersect(g, rownames(mat)))
cd_cluster_lists <- lapply(cd_cluster_lists, function(g) safe_intersect(g, rownames(mat)))

# Generate heatmaps per cluster
for (cluster_name in names(uc_cluster_lists)) {
  genes <- uc_cluster_lists[[cluster_name]]
  if (length(genes) > 1) {
    pheatmap(
      mat[genes, ],
      scale = "row",
      annotation_col = metadata[, c("sample", "condition")],
      filename = paste0("results/heatmaps/UC_", cluster_name, "_cluster_heatmap.png")
    )
  }
}

for (cluster_name in names(cd_cluster_lists)) {
  genes <- cd_cluster_lists[[cluster_name]]
  if (length(genes) > 1) {
    pheatmap(
      mat[genes, ],
      scale = "row",
      annotation_col = metadata[, c("sample", "condition")],
      filename = paste0("results/heatmaps/CD_", cluster_name, "_cluster_heatmap.png")
    )
  }
}
