
#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import tidyr
#' @import dplyr
#' @importFrom utils read.delim
#' @importFrom rhandsontable rhandsontable renderRHandsontable hot_cols hot_rows
#' @importFrom htmlwidgets JS
#' @importFrom htmltools HTML
#' @importFrom jsonlite toJSON
#' @importFrom rlang .data
#' @import writexl
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  ##############################################################################
  ###################### MODAL DIALOG FOR LEGAL DISCLAIMER #####################
  ##############################################################################
  query_modal <- modalDialog(
    title = "Legal Disclaimer",
    "This Technology Assessment Framework document is provided by the Clinical 
    Research Data Sharing Alliance (CRDSA) 'AS IS' and any express or implied 
    warranties, including, but not limited to, the implied warranties of 
    merchantability and fitness for a particular purpose, are disclaimed. In no 
    event shall CRDSA be liable for any direct, indirect, incidental, special, #
    exemplary, or consequential arising in any way out of the use and/or 
    publication of this document. The Alliance also makes no guarantee or warranty 
    as to the accuracy or completeness of any information published herein.",
    easyClose = T,
    size="l",
    footer=NULL
  )
  
  # Show the model on start up
  showModal(query_modal)
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  
  
  ##############################################################################
  ############################ REACTIVE VARIABLES ##############################
  ##############################################################################
  
  summary_tb <- shiny::reactiveVal(
    intial_summary_table
  )
  
  df_reactive <- shiny::reactiveValues(
    data = df_original_data
  )
  
  action_pressed <- shiny::reactiveValues(
    pressed = FALSE
  )
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  


  
  ##############################################################################
  ############################ ASSEESSMENT TABLE  ##############################
  ##############################################################################
  # TABLE WITH THE CHECKBOXES
  output$hot1 <- rhandsontable::renderRHandsontable({
    
    rhandsontable::rhandsontable(data = df_reactive$data,
                  rowHeaders = NULL,
                  afterGetColHeader = htmlwidgets::JS(htmltools::HTML(
                    sprintf(
                      "
                      function(i, TH) {
                        var titleLookup = %s;
                        if (TH.hasOwnProperty('_tippy')) {
                          TH._tippy.destroy();
                        }
                        tippy(TH, {
                          content: titleLookup[i].desc,
                        });
                      }
                      ",
                      jsonlite::toJSON(
                        utils::read.delim(
                          textConnection('
                          [,1]	Requirements              
                          [,2]	Category	 
                          [,3]	Dimension	
                          [,4]	Requirement	
                          [,5]	Met	
                          [,6]	Technical and Infrastructure Considerations	
                          [,7]	Data limited to on-platform tools or remote interrogation	Access to contributed data  is limited to on-platform tools / remote interrogation. Datasets may not be downloaded, option to limit on-platform dataset access.
                          [,8]	Researchers can access and download datasets	Contributor will allow researchers to access and download datasets.
                          [,9]	Remote Data Interrogation	Remote Data Interrogation: Analysis "taken to the data." The researcher can query but not view or otherwise access the underlying datasets.
                          [,10]	Locked Box	"Locked Box;" Data is accessed/analyzed within the platform.
                          [,11]	Data Released to Researcher	Data Released to the Researcher: This allows the researcher to use their own analytics platform.
                          [,12]	Regulatory Use	Regulatory Use: Data is Released to the Researcher for use in a regulatory setting.'
                          ),
                          header = FALSE,
                          col.names = c("loc", "id", "desc"),
                          stringsAsFactors = FALSE
                        ),
                        auto_unbox = TRUE
                      )
                    ))
                  ),
                  colHeaders = html_headers,
                  height = 570,
                  stretchH = "all",
                  contextMenu = FALSE
    ) %>%
      rhandsontable::hot_cols(
        colWidths = c(50, 80, 70, 150, 60, rep(95, 7))
      ) 
  })
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  
  
  ##############################################################################
  ############################### SUMMARY TABLE ################################
  ##############################################################################
  # TABLE WITH THE SUMMARY
  output$hot2 <- rhandsontable::renderRHandsontable({
    shiny::validate(
      need(isTRUE(action_pressed$pressed), "Press the 'Summary' button")
    )
    rhandsontable::rhandsontable(
      summary_tb(),
      height = 450,
      rowHeaderWidth = 80,
      stretchH = "all",
      contextMenu = FALSE
    ) %>%
      rhandsontable::hot_cols(
        colWidths = c(80, 80, 80, 80, 80, 80, 80)
      )
  })
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  
  
  ##############################################################################
  ############################ REACTIVE EXPRESSIONS ############################
  ##############################################################################
  
  # Updates data showed in the table outpud and saves the the input of the user 
  update_data <- reactive({
    current_selected_category <- input$selected_category
    df_current_state <- rhandsontable::hot_to_r(input$hot1)
    
    if (is.null(df_reactive$modified_data)) {
      df_reactive$modified_data <- df_original_data
    }
    df_reactive$modified_data[rownames(df_current_state), ] <- df_current_state
    
    df_all_rows <- df_reactive$modified_data
    
    if (!(input$selected_category == "All")) {
      df_all_rows <- df_all_rows %>%
        dplyr::filter(.data$Category == input$selected_category)
    }
    
    df_reactive$data <- df_all_rows 
  })
  
  # Filters the assessment data based on the user input
  filtered_data <- reactive({
    current_selection <-  input$view
    hot_current_state <-  df_reactive$modified_data
    
    if (!is.null(current_selection)) {
      summary_table <- summarize_table(hot_current_state, current_selection)
      summary_table[5, ] <- paste0(round(summary_table[5, ], 1), "%")
    }
    
    summary_tb(NULL)
    return(summary_tb(summary_table))
  })
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  
  
  ##############################################################################
  ####################### OBSERVE FOR CHANGES AND UPDATES ######################
  ##############################################################################
  observeEvent(input$update, {
    action_pressed$pressed <- TRUE
  }) 
  
  observeEvent(input$selected_category, {
    update_data()
  })
  
  observeEvent(input$update, {
    update_data()
    filtered_data()
  })
  
  observeEvent(input$view, {
    filtered_data()
  })
  
  ##############################################################################
  ##############################################################################
  ##############################################################################
  
  ##############################################################################
  ###################### DOWNLOAD DATA FUNCTIONALITY ###########################
  ##############################################################################
  observeEvent(input$downloadBtn, {
    showModal(modalDialog(
      title = "Download Options",
      textInput("file_name", "File Name:", placeholder = "Enter file name"),
      downloadButton("downloadBtn1", "Download Assessment"),
      downloadButton("downloadBtn2", "Download Summary"),
      footer = NULL,
      easyClose = T
    ))
  })
  
  output$downloadBtn1 <- downloadHandler(
    filename =function() {paste0(input$file_name, "_assessment.xlsx")},
    content = function(file) {writexl::write_xlsx(df_reactive$data, path = file)}
  )
  output$downloadBtn2 <- downloadHandler(
    filename = function() {paste0(input$file_name, "_summary.xlsx")},
    content = function(file) {writexl::write_xlsx(summary_tb(), path = file)}
  )
  ##############################################################################
  ##############################################################################
  ##############################################################################
}
