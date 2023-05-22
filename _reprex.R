
janitor::clean_names(palmerpenguins::penguins_raw) |>
  names() |> dput()

gg_color_scatter_facet(
  df = janitor::clean_names(palmerpenguins::penguins),
  x_var = "bill_length_mm",
  y_var = "bill_depth_mm",
  col_var = "sex",
  facet_var = "species",
  alpha = 0.5,
  size = 2
)
# Warning: Error in [[: Column `species` not found in `.data`.
gg_color_scatter_facet(
  df = janitor::clean_names(palmerpenguins::penguins_raw),
  x_var = 'sample_number',
  y_var = 'date_egg',
  col_var = 'clutch_completion',
  facet_var = "race1",
  alpha = 1 / 3,
  size = 2
)
