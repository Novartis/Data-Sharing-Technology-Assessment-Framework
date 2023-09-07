
#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @importFrom rhandsontable rHandsontableOutput hot_to_r
#' @noRd
app_ui <- function(request) {
  ##############################################################################
  ############################ VARIABLES WE NEED ###############################
  ##############################################################################
  text_jumb1 <- "The Clinical Research Data Sharing Alliance (CRDSA) Technology 
        and Innovation Work Group has developed this data-sharing technology 
        assessment framework to support stakeholders in their evaluation of 
        technologies and approaches that advance their data-sharing initiatives.\n
          The framework provides baseline requirements organized in 6 categories 
        (Access, Audit & Tracking, Data Management, Infrastructure, Search, 
        Security & Privacy). The framework allows for selection of specific 
        requirements applicable to 7 Use Cases defined for three primary user 
        groups (Platform, Data Contributor, and Researcher)."
  
  text_jumb2 <- "Acknowledgements to the CRDSA Technology and Innovation Work Group:
          Peter Mesenbrink (Work Group Chair, Novartis), Dave Alonso (The Michael 
          J. Fox Foundation), Alain Njimoluh Anyouzoa (Takeda), Luk Arbuckle 
          (Privacy Analytics), Debbie Bucci (Equideum Health), Srikanth Emmadi 
          (GSK), Cathal Gallagher (D-Wise), Matt Harvey (AstraZeneca), Aaron Mann 
          (CRDSA), Lucy Mosquera (Replica Analytics), Neil Postlethwaite (Health 
          Data Research UK), Mai Tran (Roche), Ramona Walls (Critical Path Institute), 
          Matthew Wien (Takeda), Julie Wood (Vivli), Shaoming Yin (Takeda)."
  
  categories <- c("All","Access", "Audit and Tracking", "Data Management", 
                  "Infrastructure", "Search", "Security and Privacy")
  
  views <- list(
    "By category" = list(
      "All categories",
      "Access", 
      "Audit and Tracking", 
      "Data Management", 
      "Infrastructure", 
      "Search", 
      "Security and Privacy"
    ),
    "By Use Case" = list(
      "All Use Cases",
      "Technical and Infrastructure Considerations",
      "Data limited to on-platform tools or remote interrogation",
      "Researchers can access and download datasets", 
      "Remote Data Interrogation", 
      "Locked Box", 
      "Data Released to Researcher", 
      "Regulatory Use"
    )
  )
  
  info_assessment <- "Select whether the technology being assessed meets the 
                      requirement (MET column). Then, select which requirements 
                      are applicable for each use case (The order may be 
                      reversed, with requirements selected each use case first)"
  
  info_summary <- "% Requirement Met per Use Case is based on the number of 
                  checked boxes and the Requirements Met=Yes for each use case"
  ##############################################################################
  ##############################################################################
  ##############################################################################
  tagList(
    golem_add_external_resources(),
    
    page_fluid(
      theme = bs_theme(version = 5L),
      fluidRow(
        column(
          width = 12,
          custom_jumbotron(
            title = "DATA SHARING TECHNOLOGY ASSESSMENT FRAMEWORK",
            lead = text_jumb1,
            status = "primary",
            href = "https://crdsalliance.org/resources/#tiwg"
          )
        )
      ),
      br(),
      br(),
      br(),
      card(
        card_header(
          h4(
            "Assessment",
            popover(
              badge(
                text = icon("question"), 
                color = "secondary", 
                id = "assessment_help", 
                style = "font-size: .5em"
              ),
              title = "How to?",
              placement = "right",
              content = info_assessment
            )
          )
        ),
        layout_sidebar(
          fillable = TRUE,
          sidebar = sidebar(
            width = 150,
            selectInput(
              inputId = "selected_category",
              label = "Category",
              choices = categories,
              selected="All categories"
            )
          ),
          rhandsontable::rHandsontableOutput("hot1")
        )
      ),
      centered_item(
        actionButton(
          inputId = "update",
          label = "Summary",
          class = "btn-secondary btn-lg mx-1"
        )
      ),
      br(),
      br(),
      br(),
      card(
        height = "400px",
        card_header(
          h4(
            "Summary",
            popover(
              badge(
                text = icon("question"), 
                color = "secondary", 
                id = "summary_help",
                style = "font-size: .5em"
              ),
              title = "How to?",
              placement = "right",
              content = info_summary
            )
          ),
        ),
        layout_sidebar(
          fillable = TRUE,
          sidebar = sidebar(
            width = 200,
            selectInput(
              inputId = "view",
              label = "View",
              choices = views
            )
          ),
          rhandsontable::rHandsontableOutput("hot2")
        )
      ),
      centered_item(
        tooltip(
          actionButton(
            "downloadBtn", 
            "Download Data",
            icon("floppy-save", lib = "glyphicon"),
            class = "btn-secondary btn-lg mx-1 float-end"
          ),
          title = "The data will be printed as it is, so consider changing 
          the table filters as you desire the output to look",
          placement = "top"
        )
      ),
      br(),
      br(),
      hr(),
      p(class = "p-3 mb-2 bg-dark-subtle", text_jumb2)
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'DataSharingTechnologyAssessmentFramework'
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
    tags$script(src = "www/js/popper.min.js"),
    tags$script(src = "www/js/tippy.min.js")
  )
}

