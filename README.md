# agricultural-labor-mechanization-analysis

This research examines how emigration, agricultural labour availability, mechanization and agricultural productivity are related across Romanian counties between 2012 and 2022, using descriptive statistics, cluster analysis and county-level fixed-effects models.

The project combines demographic, agricultural, labour-market and climate data from INS, Eurostat and Copernicus ERA5-Land.

## Repository Note

This repository is a reorganized and cleaned version of the analytical workflow developed for the original dissertation and is not an exact reproduction of the original project structure.

Notebooks and datasets were reorganized for clarity and reproducibility. Redundant intermediate files and exports were removed, while the analytical methodology and final model specifications were preserved.

## Data Preparation

The preprocessing workflow:

- processes ERA5-Land temperature and precipitation data and aggregates them to county-year level;
- integrates datasets using county and year as panel keys;
- constructs agricultural productivity, migration, labour, mechanization and control variables;
- creates additional AFF employment indicators for the Eurostat-based analyses;
- standardizes variables required for the statistical models;
- prepares the final analytical datasets used in R.

## Processed Datasets

Two analytical datasets are used due to differences in the measurement of agricultural employment:

- `analysis_dataset_eurostat.csv` — main analytical dataset using Eurostat employment in agriculture, forestry and fishing (AFF).
- `analysis_dataset_ins.csv` — alternative dataset using agricultural employment data from the Romanian National Institute of Statistics (INS), used for robustness and complementary analyses.

## Mechanization Index Construction

Two alternative mechanization indices are evaluated.

### Density-Based Mechanization Index

The first index measures machinery intensity relative to cultivated area. Machinery indicators are standardized and combined into a composite index. Cronbach's alpha and PCA are used to evaluate the consistency and structure of the machinery indicators.

### Residual Mechanization Index

The second index accounts for structural differences in cultivated area between counties. For each machinery category, machinery stocks are modeled as a function of cultivated area and year effects. The resulting residuals are standardized and averaged across tractors, ploughs, mechanical seeders and combine harvesters.

The residual index is compared with the density-based index and evaluated using Cronbach's alpha and item-deletion analysis.

## Cluster Analysis

County-level patterns are explored using PCA and k-means clustering. The analysis reduces correlated indicators into principal components and groups counties according to similarities in migration, agricultural labour, mechanization, agricultural structure and productivity.

Alternative numbers of clusters are evaluated before selecting the final clustering solution.