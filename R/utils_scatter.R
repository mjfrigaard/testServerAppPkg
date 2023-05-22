#' Base plot (ggplot2)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable
#' @param y_var y variable
#'
#' @return plot object
#' @export gg_base
#'
#' @importFrom ggplot2 ggplot aes
#'
#' @examples
#' require(palmerpenguins)
#' penguins <- palmerpenguins::penguins
#' gg_base(df = penguins, x_var = "bill_length_mm", y_var = "body_mass_g")
gg_base <- function(df, x_var, y_var) {
  ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]])
  )
}

#' Point plot (scatter-plot)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param y_var y variable (supplied to `ggplot2::aes(y = )`)
#' @param ... other arguments passed to `ggplot2::geom_point()`, outside of `ggplot2::aes()`
#'
#' @return A `ggplot2` plot object
#' @export gg_scatter
#'
#' @importFrom ggplot2 ggplot aes geom_point
#' @importFrom ggplot2 labs theme_minimal theme
#' @importFrom stringr str_replace_all
#' @importFrom snakecase to_title_case
#'
#' @examples
#' require(palmerpenguins)
#' penguins <- palmerpenguins::penguins
#' gg_scatter(
#'   df = penguins,
#'   x_var = "bill_length_mm",
#'   y_var = "body_mass_g",
#'   alpha = 1 / 3,
#'   color = "#000000",
#'   size = 2
#' )
gg_scatter <- function(df, x_var, y_var, ...) {

  base <- gg_base(df = df, x_var = x_var, y_var = y_var)

  base +
    ggplot2::geom_point(...) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
}

#' Make plot title
#'
#' @param x x variable
#' @param y y variable
#' @param color color variable
#'
#' @return String for plot title
#' @export make_plot_title
#'
#' @importFrom glue glue
#' @importFrom stringr str_replace_all
#' @importFrom snakecase to_title_case
#'
#' @examples
#' make_plot_title(
#'   x = "imdb_rating",
#'   y = "audience_score",
#'   color = "mpaa_rating"
#' )
make_plot_title <- function(x, y, color) {
  x_chr <- stringr::str_replace_all(
    snakecase::to_title_case(x), "_", " "
  )
  y_chr <- stringr::str_replace_all(
    snakecase::to_title_case(y), "_", " "
  )
  color_chr <- stringr::str_replace_all(
    snakecase::to_title_case(color), "_", " "
  )
  glue::glue("{x_chr} vs. {y_chr} by {color_chr}")
}

#' Colored point plot (scatter-plot)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param y_var y variable (supplied to `ggplot2::aes(y = )`)
#' @param col_var color variable (supplied to `ggplot2::geom_point(ggplot2::aes(color = ))`)
#' @param ... other arguments passed to `ggplot2::geom_point()`, outside of `ggplot2::aes()`
#'
#' @return A `ggplot2` plot object
#' @export gg_color_scatter
#'
#' @importFrom ggplot2 ggplot aes geom_point
#' @importFrom ggplot2 labs theme_minimal theme
#' @importFrom stringr str_replace_all
#' @importFrom snakecase to_title_case
#'
#' @examples
#' require(palmerpenguins)
#' penguins <- palmerpenguins::penguins
#' gg_color_scatter(
#'   df = penguins,
#'   x_var = "bill_length_mm",
#'   y_var = "body_mass_g",
#'   col_var = "species",
#'   alpha = 1 / 3,
#'   size = 2
#' )
gg_color_scatter <- function(df, x_var, y_var, col_var, ...) {
  base <- gg_base(df = df, x_var = x_var, y_var = y_var)

  base +
    ggplot2::geom_point(
      ggplot2::aes(color = .data[[col_var]]), ...
    ) +

    ggplot2::labs(
      title = make_plot_title(x = x_var, y = y_var, color = col_var),
      x = stringr::str_replace_all(
        snakecase::to_title_case(x_var), "_", " "
      ),
      y = stringr::str_replace_all(
        snakecase::to_title_case(y_var), "_", " "
      ),
      color = stringr::str_replace_all(
        snakecase::to_title_case(col_var), "_", " "
      )
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
}


#' Colored point plot (scatter-plot) with facets
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param y_var y variable (supplied to `ggplot2::aes(y = )`)
#' @param col_var color variable (supplied to `ggplot2::geom_point(ggplot2::aes(color = ))`)
#' @param facet_var facet variable (supplied to `ggplot2::geom_point(ggplot2::aes(color = ))`)
#' @param ... other arguments passed to (`ggplot2::facet_wrap(vars())`)
#'
#' @return A `ggplot2` plot object
#' @export gg_color_scatter_facet
#'
#' @importFrom ggplot2 ggplot aes vars facet_wrap geom_point labs
#' @importFrom rlang .data
#'
#' @examples
#' require(palmerpenguins)
#' gg_color_scatter_facet(
#'   df = palmerpenguins::penguins,
#'   x_var = "bill_length_mm",
#'   y_var = "flipper_length_mm",
#'   col_var = "island",
#'   facet_var = "species",
#'   alpha = 1 / 3,
#'   size = 2
#' )
#' gg_color_scatter_facet(
#'   df = palmerpenguins::penguins,
#'   x_var = "bill_length_mm",
#'   y_var = "flipper_length_mm",
#'   col_var = "island",
#'   facet_var = NULL,
#'   alpha = 1 / 3,
#'   size = 2
#' )
#' gg_color_scatter_facet(
#'   df = palmerpenguins::penguins,
#'   x_var = "bill_length_mm",
#'   y_var = "flipper_length_mm",
#'   col_var = NULL,
#'   facet_var = NULL,
#'   alpha = 1 / 3,
#'   size = 2
#' )
gg_color_scatter_facet <- function(df, x_var, y_var, col_var, facet_var, ...) {
  # create base
  base <- ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]]))

  # build color layer
  if (is.null(col_var)) {
   col_var <- "#000000"
   color_layer <- ggplot2::geom_point(...)
  } else {
   color_layer <- ggplot2::geom_point(
                    # add ... for alpha and size passed to points
                    ggplot2::aes(colour = .data[[col_var]]), ...)
  }

  # build facet layer
  if (is.null(facet_var)) {
    facet_layer <- NULL
  } else {
    facet_layer <- ggplot2::facet_wrap(ggplot2::vars(.data[[facet_var]]))
  }

  base +
    # points layer
    color_layer +
    # facet layer
    facet_layer +
    # labels
    ggplot2::labs(
      title = make_plot_title(x = x_var, y = y_var, color = col_var),
      x = stringr::str_replace_all(
        snakecase::to_title_case(x_var), "_", " "
      ),
      y = stringr::str_replace_all(
        snakecase::to_title_case(y_var), "_", " "
      ),
      color = stringr::str_replace_all(
        snakecase::to_title_case(col_var), "_", " "
      )
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
}
