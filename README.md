# CSS Bootcamp — AI Debugging: Broken Pipeline

## What the script does

`fixed_pipeline.R` is a small R data pipeline built with the **tidyverse** (dplyr + ggplot2):

1. Loads the built-in `swiss` dataset (socio-economic indicators of 25 French-speaking Swiss provinces, 1888).
2. Filters provinces where `Catholic > 50` (%) and flags them with `is_majority`.
3. Computes summary statistics on that subset: average fertility, average education, and maximum agricultural land share.
4. Draws a scatterplot of average fertility vs. average education and saves it as `outputs/my_plot.png` (creating the `outputs/` directory first if needed).

The original `broken_pipeline.R` is kept as-is for debugging practice.

## Changelog — bugs fixed from `broken_pipeline.R`

- **Wrong package name**: `library(ggplot)` → `library(ggplot2)` (there is no R package called `ggplot`).
- **Typo in object name**: `df <- swis` → `df <- swiss` (`object 'swis' not found`).
- **Invalid logical literal**: `mutate(is_majority = True)` → `TRUE` (R only knows `TRUE`/`FALSE`, not `True`).
- **Missing closing parenthesis**: `mean(Education, na.rm = T,` had an unclosed `mean()` call, leaving `summarize()` unbalanced and making the whole script fail to parse; the parenthesis is now correctly closed.
- **Inconsistent / fragile `na.rm`**: `na.rm = TRUE` is now applied to every summary function (`mean(Fertility)`, `mean(Education)`, `max(Agriculture)`), instead of only one.
- **`T` shorthand replaced**: `na.rm = T` → `na.rm = TRUE` (`T` can be overwritten by the user).
- **Mixed pipe and `+` operators**: `ggplot(...) |> geom_point() + theme_minimal()` parsed as `ggplot(...) |> (geom_point() + theme_minimal())` and broke the plot; the whole plot is now built with `+` only.
- **Detached `labs()` call**: `labs(title = ...)` was a separate statement without `+`, so the title was never applied to the plot; it is now chained onto the plot.
- **Missing output directory**: `ggsave("outputs/my_plot.png", ...)` failed when `outputs/` did not exist; the script now runs `dir.create("outputs")` if `dir.exists("outputs")` is `FALSE` before saving.

## How to run

Requirements: R (≥ 4.0) with the `tidyverse` package installed.

```r
install.packages("tidyverse")   # once, if needed
```

From this directory (`css-bootcamp-ai-debugging/`):

```sh
Rscript fixed_pipeline.R
```

Or interactively in R / RStudio:

```r
source("fixed_pipeline.R")
```

Expected result: the console prints tidyverse startup messages and `Saving 7 x 7 in image`, and the plot is written to `outputs/my_plot.png`.
