source("renv/activate.R")

Sys.setenv(
  "RENV_PATHS_CACHE" = "~/.renv/cache",
  "RENV_PATHS_LIBRARY_ROOT" =  "~/.renv/library"
)

options(
  renv.config.rspm.enabled = FALSE,
  renv.config.mran.enabled = FALSE,
  repos = c(
    CRAN = "https://packagemanager.posit.co/cran/2023-07-04",
    BioCsoft = "https://bioconductor.org/packages/3.14/bioc",
    BioCann = "https://bioconductor.org/packages/3.14/data/annotation",
    BioCexp = "https://bioconductor.org/packages/3.14/data/experiment",
    RSPM = "https://packagemanager.posit.co/cran/latest"
  )
)
