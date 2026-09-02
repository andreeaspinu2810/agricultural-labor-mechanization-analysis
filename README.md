# agricultural-labor-mechanization-analysis

This research examines how emigration, agricultural labour availability, mechanization and agricultural productivity are related across Romanian counties between 2012 and 2022, using descriptive statistics, cluster analysis and county-level fixed-effects models.

The project combines demographic, agricultural, labour-market and climate data from INS, Eurostat and Copernicus ERA5-Land.

## Repository Note

This repository is a reorganized and cleaned version of the analytical workflow developed for the original dissertation and is not an exact reproduction of the original project structure.

Notebooks and datasets were reorganized for clarity and reproducibility. Redundant intermediate files and exports were removed, while the analytical methodology and final model specifications were preserved.


## Research Focus

The project investigates four main relationships:

- whether higher emigration is associated with changes in agricultural labour availability;
- whether lower agricultural labour availability is associated with higher levels of mechanization;
- whether mechanization is positively associated with crop productivity;
- whether declining agricultural employment is associated with lower crop productivity.

The analysis is conducted at county-year level for Romanian counties between 2012 and 2022.


## Data Preparation

The preprocessing workflow:

- processes ERA5-Land temperature and precipitation data and aggregates them to county-year level;
- integrates datasets using county and year as panel keys;
- constructs agricultural productivity, migration, labour, mechanization and control variables;
- creates additional AFF employment indicators for the Eurostat-based analyses;
- standardizes variables required for the statistical models;
- prepares the final analytical datasets used in R.


## Technical Tools

The project uses Python for data cleaning, variable construction, climate-data processing, index construction and exploratory analysis. R is used for the fixed-effects regression models. GIS-based processing is used to aggregate ERA5-Land climate data to county-year level.

Excel and Power Query were used in the original workflow to clean and organize some of the initial datasets downloaded from the Romanian National Institute of Statistics (INS). These original Excel-based preprocessing files are not included in the repository, as the cleaned and processed datasets are provided directly.

## Processed Datasets

Two analytical datasets are used due to differences in the measurement of agricultural employment:

- `analysis_dataset_eurostat.csv` — main analytical dataset using Eurostat employment in agriculture, forestry and fishing (AFF).
- `analysis_dataset_ins.csv` — alternative dataset using agricultural employment data from the Romanian National Institute of Statistics (INS), used for robustness and complementary analyses.

For the R fixed-effects models, equivalent English-column versions of these datasets are also included:

- `dataset_final_R_panel_en_H2_AFF.csv` — English-column version of the Eurostat/AFF analytical dataset used in the R models.
- `dataset_final_R_panel_en_H2.csv` — English-column version of the INS analytical dataset used in the R robustness specifications.


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


## R Model Specifications

The R scripts include the main fixed-effects models used to test the research hypotheses. For H3, which examines the association between mechanization and crop productivity, a more detailed sequence of model specifications is shown for wheat yield. For maize and sunflower, only the main climate-control specifications are retained in order to avoid redundant exploratory models and keep the repository concise.


## Main Findings

The fixed-effects models provide support for the relationship between emigration and changes in AFF employment share. The main Eurostat-based models do not provide strong support for the relationship between lower agricultural labour availability and higher mechanization, although the INS-based robustness specifications offer partial support.

The residual mechanization index is not positively and statistically significantly associated with crop productivity across the crop-specific models. The relationship between declining AFF employment and crop productivity is only partially supported and becomes weaker once climate controls are included.