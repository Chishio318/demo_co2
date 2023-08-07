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


ggplot2::ggplot(df,
                ggplot2::aes(
                  x = log10(gdp_per_capita),
                  y = log10(co2_per_capita),
                  color = region,
                  size = population
                )
                ) +
  ggplot2::geom_point(
    alpha = 0.5
  ) +
  ggplot2::scale_x_continuous(
    breaks = c(log10(1000), log10(10000), log10(100000)),
    labels = c("1000", "10000", "100000")
  ) +
  ggplot2::scale_y_continuous(
    breaks = c(log10(0.1), log10(1), log10(10)),
    labels = c("0.1", "1", "10")
  ) +
  ggplot2::labs(
    x = "GDP per capita (USD)",
    y = "CO2 per capita (tons)",
    title = "CO2 per capita vs. GDP per capita, 2015"
  ) +
  ggplot2::theme_bw() +
  ggplot2::geom_text(ggplot2::aes(label = iso_code,
                                  size = 6)) +
  ggplot2::guides(size = "none")


