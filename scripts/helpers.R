# ============================
# helpers.R
# ============================

create_dirs <- function() {
  dirs <- c("results", 
            "results/QC", 
            "results/DEG", 
            "results/heatmaps",
            "results/pathways",
            "results/deconvolution")
  
  for (d in dirs) if (!dir.exists(d)) dir.create(d, recursive = TRUE)
}

load_gene_list <- function(path) {
  if (!file.exists(path)) stop(paste("Gene list not found:", path))
  read.table(path, header = TRUE, stringsAsFactors = FALSE) |> 
    dplyr::rename(GeneID = 1) |> 
    dplyr::distinct(GeneID)
}

safe_intersect <- function(list1, list2) {
  intersect(toupper(list1), toupper(list2))
}
