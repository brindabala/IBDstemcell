# PDO RNA-seq Analysis (Healthy vs IBD)

This repository contains a complete RNA-seq analysis workflow for 20 PDO samples  
(7 Healthy P12 samples, 13 IBD samples including late-passage P99 NI).

## Structure
- `data/` — raw counts + gene lists  
- `scripts/` — modular R pipeline  
- `results/` — QC, DEG, heatmaps, pathways, deconvolution  

## Pipeline
1. Load & clean counts  
2. Prepare metadata  
3. DESeq2 differential expression  
4. Heatmap visualization  
5. Inflammatory gene analysis  
6. SPIA pathway analysis  
7. Immune deconvolution  

Each script is self-contained and reproducible.
