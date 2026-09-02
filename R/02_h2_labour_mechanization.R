

# Load required packages & analytical datasets used by the original R models

source("R/00_load_data.R")



# H2: Testing whether lower agricultural labour availability is associated with higher levels of agricultural mechanization

df <- df_aff

dim(df)
names(df)
str(df)



# H2: Testing whether lower agricultural labour availability is associated with higher levels of agricultural mechanization

# County fixed-effects model

h2_county_fe <- feols(
  z_residual_mechanization_index ~ 
    z_aff_workers_per_1000ha + 
    z_rural_population_share + 
    z_log_selected_crop_area | 
    county,
  data = df,
  vcov = ~ county
)

summary(h2_county_fe)

# AFF workers per 1,000 hectares is negative, but not statistically significant.
# The R-squared is high, suggesting that county fixed effects explain a large share of the differences in mechanization levels.
# The within R-squared is low, indicating limited explanatory power for within-county variation over time.



# Two-way fixed-effects model: county and year fixed effects

h2_twoway_fe <- feols(
  z_residual_mechanization_index ~
    z_aff_workers_per_1000ha +
    z_rural_population_share +
    z_log_selected_crop_area |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h2_twoway_fe)

# AFF workers per 1,000 hectares is negative, meaning that the coefficient is in the expected direction,
# but it is not statistically significant.
# Therefore, H2 is not supported in this model.



# Use INS dataset for the robustness check
df <- df_ins


# Robustness check: two-way fixed-effects model using INS agricultural employment data

# Keep observations up to and including 2020
df_2020 <- df %>%
  mutate(year = as.numeric(as.character(year))) %>%
  filter(year <= 2020)

nrow(df_2020)
length(unique(df_2020$year))
length(unique(df_2020$county))

h2_ins_twoway_fe_2020 <- feols(
  z_residual_mechanization_index ~
    z_agri_workers_per_1000ha +
    z_rural_population_share |
    county + year,
  data = df_2020,
  vcov = ~ county
)

summary(h2_ins_twoway_fe_2020)

# Agricultural workers per 1,000 hectares is negative and statistically significant.
# This result supports H2 in the INS-based robustness specification.
# A one-standard-deviation increase in agricultural workers per 1,000 hectares
# is associated with an approximately 0.360 standard-deviation decrease in the residual mechanization index.
# The R-squared is approximately 0.919.
# The within R-squared is approximately 0.075, indicating that the model explains about 7.5% of within-county variation.




# Robustness check: alternative model with winsorized INS agricultural employment variable

# Use INS dataset
df <- df_ins

# Winsorize values at the 1st and 99th percentiles
winsorize_1_99 <- function(x) {
  q_low <- quantile(x, 0.01, na.rm = TRUE)
  q_high <- quantile(x, 0.99, na.rm = TRUE)
  pmin(pmax(x, q_low), q_high)
}

df <- df %>%
  mutate(
    agri_workers_per_1000ha_w = winsorize_1_99(agri_workers_per_1000ha),
    z_agri_workers_per_1000ha_w = as.numeric(scale(agri_workers_per_1000ha_w))
  )

h2_winsor <- feols(
  z_residual_mechanization_index ~
    z_agri_workers_per_1000ha_w +
    z_rural_population_share |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h2_winsor)

# After winsorization, H2 is supported in this alternative specification.
# The winsorized agricultural workers per 1,000 hectares variable is negative and statistically significant.
# This suggests that lower agricultural labour availability is associated with higher residual mechanization.
# The adjusted R-squared is approximately 0.892.
# The within R-squared is approximately 0.162.
