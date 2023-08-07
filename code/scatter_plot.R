df_raw <- readr::read_csv("data/owid-co2-data.csv")

dplyr::glimpse(df_raw)

df <- df_raw |>
  dplyr::select(
    country:gdp,
    co2_per_capita
    ) |>
  dplyr::filter(
    year == 2015
  )
