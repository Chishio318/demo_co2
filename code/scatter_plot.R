df_raw <- readr::read_csv("data/owid-co2-data.csv")

df_continent <- readr::read_csv("data/all.csv")


# dplyr::glimpse(df_raw)

df <- df_raw |>
  dplyr::select(
    country:gdp,
    co2_per_capita
  ) |>
  dplyr::filter(
    year == 2015 & 
      !is.na(gdp)
  ) |> 
  dplyr::mutate(
    gdp_per_capita = gdp / population
  )

df_continent_id <- df_continent |> 
  dplyr::select(
    iso_code = `alpha-3`, 
    region
  )

df <- df |> 
  dplyr::left_join(
    df_continent_id, 
    by = "iso_code"
  )




