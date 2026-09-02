# Load required packages & analytical datasets used by the original R models


source("R/00_load_data.R")

# Use Eurostat AFF dataset for the main models
df <- df_aff

# Initial checks
dim(df)
names(df)
str(df)

# Load required packages

install.packages(c("plm", "lmtest", "sandwich", "fixest", "modelsummary"))


library(plm)
library(lmtest)
library(sandwich)
library(fixest)
library(modelsummary)


pdata <- pdata.frame(df, index = c("county", "year"))



# H1: Testing whether a higher emigration rate is associated with changes in AFF employment share

simplereg <- lm(z_change_aff_employment_share ~ z_emigration_rate_15_64 + z_rural_population_share + z_log_selected_crop_area, data = pdata)
summary(simplereg)

# Simple exploratory OLS model

h1_ols_simple <- lm(
  z_change_aff_employment_share ~
    z_emigration_rate_15_64,
  data = pdata
)

summary(h1_ols_simple)

# The emigration rate is statistically significant, but it is positively associated with the change in AFF employment share.
# The R-squared is low, at approximately 0.01.


# Simple OLS model with control variables

h1_ols_controls <- lm(
  z_change_aff_employment_share ~
    z_emigration_rate_15_64 +
    z_rural_population_share + 
    z_log_selected_crop_area,
  data = pdata
)

summary(h1_ols_controls)

# The emigration rate remains positive and statistically significant.
# Rural population share is negative, but not statistically significant.
# Selected crop area is negative and statistically significant.
# The R-squared remains low, but improves compared to the simple OLS model.



# County fixed-effects model

h1_county_fe <- feols(
  z_change_aff_employment_share ~
    z_emigration_rate_15_64 + 
    z_rural_population_share + 
    z_log_selected_crop_area |
    county,
  data = pdata,
  vcov = ~ county
)

summary(h1_county_fe)

# The vcov argument computes standard errors clustered at the county level.
# The emigration rate remains positive, but becomes statistically insignificant.



# Two-way fixed-effects model: county and year fixed effects

h1_twoway_fe <- feols(
  z_change_aff_employment_share ~
    z_emigration_rate_15_64 +
    z_rural_population_share +
    z_log_selected_crop_area |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h1_twoway_fe)
# After introducing both county and year fixed effects, the emigration rate becomes negative and statistically significant.
# This model supports H1.
# A one-standard-deviation increase in the emigration rate is associated with an approximately 0.155 standard-deviation lower change in AFF employment share,
# controlling for rural population share and selected crop area.
# Selected crop area is negative, but not statistically significant.
# The adjusted R-squared remains relatively low, but is higher than in the initial models.
# The within R-squared indicates that the model has limited explanatory power for within-county variation.




# Two-way fixed-effects model with climate controls

h1_twoway_fe_climate <- feols(
  z_change_aff_employment_share ~
    z_emigration_rate_15_64 +
    z_rural_population_share +
    z_log_selected_crop_area +
    z_annual_mean_temperature_c +
    z_annual_precipitation_mm |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h1_twoway_fe_climate)

# The emigration rate remains negative and statistically significant.
# This model supports H1.
# Within the same county, in years when the emigration rate among the population aged 15-64 is one standard deviation higher,
# the change in AFF employment share is approximately 0.143 standard deviations lower.
# The model controls for climate variables, rural population share, selected crop area, county fixed effects and year fixed effects.
# Selected crop area remains negative and becomes statistically significant.
# Annual mean temperature is negative and statistically significant, suggesting that agro-climatic variation is relevant for agricultural labour dynamics.
# The adjusted R-squared improves compared to the previous model without climate controls.
# The within R-squared also improves compared to the previous model, although its value remains modest.





# Lagged emigration model

library(dplyr)

df <- df %>%
  arrange(county, year) %>%
  group_by(county) %>%
  mutate(
    lag_z_emigration_rate_15_64 = lag(z_emigration_rate_15_64, 1)
  ) %>%
  ungroup()

h1_lag <- feols(
  z_change_aff_employment_share ~
    lag_z_emigration_rate_15_64 +
    z_rural_population_share +
    z_log_selected_crop_area +
    z_annual_mean_temperature_c +
    z_annual_precipitation_mm |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h1_lag)

# The lagged emigration rate remains negative and statistically significant.
# A one-standard-deviation increase in the emigration rate among the population aged 15-64 in the previous year
# is associated with an approximately 0.251 standard-deviation lower change in AFF employment share in the current year.
# The model controls for climate variables, rural population share, selected crop area, county fixed effects and year fixed effects.
# Selected crop area remains negative and statistically significant, as does annual mean temperature.
# The adjusted R-squared is approximately 0.227.
# The within R-squared is approximately 0.062.

