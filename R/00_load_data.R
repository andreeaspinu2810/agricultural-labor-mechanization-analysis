# Load required packages
library(plm)
library(lmtest)
library(sandwich)
library(fixest)
library(modelsummary)
library(dplyr)

# Load analytical datasets used in the R models
df_aff <- read.csv("data/processed/dataset_final_R_panel_en_H2_AFF.csv")
df_ins <- read.csv("data/processed/dataset_final_R_panel_en_H2.csv")
