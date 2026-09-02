
# Load required packages & analytical datasets used by the original R models

source("R/00_load_data.R")



# Use the main Eurostat AFF dataset for H3
df <- df_aff



# H3: Testing whether agricultural mechanization is positively associated with agricultural productivity

# Separate models are estimated for each crop: wheat, maize and sunflower.

# Wheat yield: simple two-way fixed-effects model

h3_wheat_fe_simple <- feols(
  wheat_yield ~ 
    z_residual_mechanization_index |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_wheat_fe_simple)

# The residual mechanization index is negative and not statistically significant.
# Therefore, this model does not support H3 for wheat yield.
# The R-squared is approximately 0.659, while the within R-squared is very low.



# H3: Testing whether agricultural mechanization is positively associated with agricultural productivity

# Separate models are estimated for each crop: wheat, maize and sunflower.

# Use the main Eurostat AFF dataset for H3
df <- df_aff


# Wheat yield: two-way fixed-effects model with additional explanatory variables

h3_wheat_fe_modf0 <- feols(
  wheat_yield ~
    residual_mechanization_index + 
    z_change_aff_employment_share + 
    z_emigration_rate_15_64 |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_wheat_fe_modf0)

# None of the explanatory variables are statistically significant in this specification.

# Wheat yield: two-way fixed-effects model with additional controls

h3_wheat_fe_modf1 <- feols(
  wheat_yield ~
    residual_mechanization_index + 
    z_change_aff_employment_share + 
    z_emigration_rate_15_64 +
    z_rural_population_share + 
    z_wheat_area_share |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_wheat_fe_modf1)

# The residual mechanization index is not statistically significant.
# Therefore, this model does not support H3 for wheat yield.
# The emigration rate is negative and statistically significant.
# The adjusted R-squared is approximately 0.590, while the within R-squared is approximately 0.025.




# Wheat yield: two-way fixed-effects model with climate controls

h3_wheat_fe_climate <- feols(
  wheat_yield ~
    z_residual_mechanization_index + 
    z_rural_population_share + 
    z_wheat_area_share + 
    z_emigration_rate_15_64 + 
    z_annual_mean_temperature_c +
    z_annual_precipitation_mm |
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_wheat_fe_climate)

# H3 is not supported for wheat yield.
# The residual mechanization index is negative and not statistically significant,
# suggesting that mechanization does not appear to be positively associated with land productivity in this model.
# Annual mean temperature is negative and statistically significant.
# The emigration rate is negative and statistically significant.
# The adjusted R-squared is approximately 0.622.
# The within R-squared is approximately 0.106.




# Sunflower yield: two-way fixed-effects model with climate controls

h3_sunflw_climate <- feols(
  sunflower_yield ~ 
    z_residual_mechanization_index + 
    z_sunflower_area_share + 
    z_rural_population_share + 
    z_emigration_rate_15_64 + 
    z_annual_precipitation_mm + 
    z_annual_mean_temperature_c | 
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_sunflw_climate)

# H3 is not supported for sunflower yield.
# The residual mechanization index remains statistically insignificant,
# suggesting that mechanization does not appear to be positively associated with land productivity in this model.
# Annual mean temperature is negative and statistically significant.
# The emigration rate is statistically significant.
# The R-squared is approximately 0.671, while the within R-squared is approximately 0.128.





# Maize yield: two-way fixed-effects model with climate controls

h3_maize_fe_climate <- feols(
  maize_yield ~ 
    z_residual_mechanization_index + 
    z_rural_population_share + 
    z_maize_area_share + 
    z_emigration_rate_15_64 + 
    z_annual_precipitation_mm + 
    z_annual_mean_temperature_c | 
    county + year,
  data = df,
  vcov = ~ county
)

summary(h3_maize_fe_climate)

# The emigration rate and annual mean temperature remain negative and statistically significant.
# The R-squared is approximately 0.802, while the within R-squared is approximately 0.196.
# Overall, H3 is not supported across the crop-specific models.
# The residual mechanization index is not positively and statistically significantly associated with wheat, sunflower or maize yields.

