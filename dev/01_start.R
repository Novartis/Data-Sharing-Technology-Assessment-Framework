
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
## 
## /!\ Note: if you want to change the name of your app during development, 
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
## 
golem::fill_desc(
  pkg_name = "DSTAF", # The Name of the package containing the App 
  pkg_title = "DSTAF", # The Title of the package containing the App 
  pkg_description = "DSTAF supports the evaluation of technologies and approaches that advance their data-sharing initiatives.", # The Description of the package containing the App 
  author_first_name = "Ines", # Your First Name
  author_last_name = "Gimeno Molina", # Your Last Name
  author_email = "ines.gimeno_molina_ext@novartis.com", # Your Email
  repo_url = "https://gitlabce.apps.dit-prdocp.novartis.net/GIMENIN2/data-sharing-technology-assessment-framework" # The URL of the GitHub Repo (optional) 
)     

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license("Novartis Institutes for BioMedical Research Inc.")  # You can set another license here
usethis::use_gpl_license(version=3)
# usethis::use_readme_rmd( open = FALSE )
# usethis::use_code_of_conduct()
# usethis::use_lifecycle_badge( "Experimental" )
# usethis::use_news_md( open = FALSE )

## Use git ----
#usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
#golem::use_recommended_tests()

## Use Recommended Packages ----
golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
# golem::use_favicon() # path = "path/to/ico". Can be an online file. 
golem::remove_favicon()

## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

## Packages that we need to run the app
usethis::use_package("tidyr")
usethis::use_package("dplyr")
usethis::use_pipe()
usethis::use_package("rhandsontable")
usethis::use_package("data.table")
usethis::use_package("writexl")
usethis::use_package("shinyWidgets")
usethis::use_package("thematic")
usethis::use_package("rlang")

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

