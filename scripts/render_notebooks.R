# Renders the three notebooks (Rmd -> md) in order, sharing one R session so that
# objects created in notebook 1 (data_twitch) are available in notebooks 2 and 3.
# Usage (from the repository root):  Rscript scripts/render_notebooks.R
# Required packages: readr, tidyverse, naniar, knitr, RColorBrewer, viridis, corrplot

options(cli.unicode = FALSE, width = 110)
knitr::opts_knit$set(root.dir = getwd())

notebooks <- c("Rmd/01_data_loading_cleaning.Rmd",
               "Rmd/02_univariate_analysis.Rmd",
               "Rmd/03_bivariate_analysis.Rmd")

for (f in notebooks) {
  out <- sub("^Rmd/", "", sub("\\.Rmd$", ".md", f))
  knitr::opts_chunk$set(
    fig.path = paste0("figures/", sub("\\.md$", "", out), "/"),
    dev = "png", dpi = 110, comment = "##", error = FALSE, fig.width = 8, fig.height = 5
  )
  knitr::knit(f, output = out, quiet = TRUE, envir = globalenv())
  message("Rendered ", out)
}
