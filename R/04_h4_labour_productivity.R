# Load required packages & analytical datasets used by the original R models

source("R/00_load_data.R")


df <- df_aff



# H4: Testing whether a decline in AFF employment is associated with lower crop productivity

# Separate models are estimated for wheat, maize and sunflower.

# Wheat yield: simple two-way fixed-effects model

h4_wheat_lp_0 <- feols(
  wheat_yield ~
    z_decline_aff_employment_share +
    z_rural_population_share +
    z_wheat_area_share |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_wheat_lp_0)

# Wheat yield: two-way fixed-effects model with climate controls

h4_wheat_lp_1 <- feols(
  wheat_yield ~
    z_decline_aff_employment_share +
    z_rural_population_share +
    z_wheat_area_share + 
    z_annual_precipitation_mm + 
    z_annual_mean_temperature_c |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_wheat_lp_1)

# Only annual mean temperature is statistically significant.
# In this model, the decline in AFF employment is not statistically associated with wheat productivity.





# Sunflower yield: two-way fixed-effects model with climate controls


# Sunflower yield: simple two-way fixed-effects model

h4_sunflw_lp0 <- feols(
  sunflower_yield ~
    z_decline_aff_employment_share +
    z_rural_population_share +
    z_sunflower_area_share |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_sunflw_lp0)

# The decline in AFF employment is negative and statistically significant.
# The R-squared is approximately 0.554, while the within R-squared is approximately 0.019.


# Sunflower yield: two-way fixed-effects model with climate controls

h4_sunflw_lp1 <- feols(
  sunflower_yield ~ 
    z_decline_aff_employment_share + 
    z_rural_population_share + 
    z_sunflower_area_share + 
    z_annual_precipitation_mm + 
    z_annual_mean_temperature_c | 
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_sunflw_lp1)

# After introducing climate variables, the decline in AFF employment becomes statistically insignificant, but remains negative.
# Annual mean temperature is negative and statistically significant.
# The R-squared is approximately 0.590.
# The within R-squared is approximately 0.102.





# Maize yield: simple two-way fixed-effects model

h4_maize_lp0 <- feols(
  maize_yield ~ 
    z_decline_aff_employment_share +
    z_rural_population_share + 
    z_maize_area_share | 
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_maize_lp0)

# The decline in AFF employment is negative and statistically significant at the 10% significance level.
# Maize area share is negative and statistically significant, suggesting that a higher maize area share is associated with lower maize productivity.
# The R-squared is approximately 0.708, while the within R-squared is low, at approximately 0.028.







# Maize yield: two-way fixed-effects model with climate controls

h4_maize_lp1 <- feols(
  maize_yield ~ 
    z_decline_aff_employment_share +
    z_rural_population_share + 
    z_maize_area_share +
    z_annual_precipitation_mm + 
    z_annual_mean_temperature_c |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h4_maize_lp1)

# As in the sunflower model with climate controls, the decline in AFF employment becomes statistically insignificant after adding climate variables.
# Annual mean temperature is statistically significant.
# The R-squared is approximately 0.757, while the within R-squared is approximately 0.190.


