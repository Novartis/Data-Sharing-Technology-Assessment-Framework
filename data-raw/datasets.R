
#' intial_summary_table_fct
#'
#' @description Create initial data to fill the summary table table
#'
#' @return summary_table_initial
#' @noRd

intial_summary_table_fct <- function() {

  cols_with_info <- c(
    "Met",
    "Technical and Infrastructure Considerations",
    "Data limited to on-platform tools or remote interrogation",
    "Researchers can access and download datasets",
    "Remote Data Interrogation",
    "Locked Box", 
    "Data Released to Researcher",
    "Regulatory Use"
  )

  summary_table_initial <- data.frame(
    c1 = rep(0, 4),
    c2 = rep(0, 4),
    c3 = rep(0, 4),
    c4 = rep(0, 4),
    c5 = rep(0, 4),
    c6 = rep(0, 4),
    c7 = rep(0, 4)
  )
  row.names(summary_table_initial) <- c("In Scope", "Met", "Not Met", "Summary")
  colnames(summary_table_initial) <- cols_with_info[2:8]
  
  return(summary_table_initial)
}

intial_summary_table <- intial_summary_table_fct()

## code to prepare `DATASET` dataset goes here

#' html_headers_fct 
#'
#' @description The headers in html for the assessment table
#' 
#' @param font_size Text size. CSS parameter.
#'
#' @return table_headers_html
#' @noRd

html_headers_fct <- function(font_size = "12px") {
  table_headers_html <- c(
    sprintf("<span style='color:#333333; font-size: %s'><b> </b></span>", font_size),
    sprintf("<span style='color:#333333; font-size: %s'><b>Category</b></span>", font_size),                                                                                
    sprintf("<span style='color:#333333; font-size: %s'><b>Dimension</b></span>", font_size),                                                                              
    sprintf("<span style='color:#333333; font-size: %s'><b>Requirement</b></span>", font_size),                                                                             
    sprintf("<span style='color:#333333; font-size: %s'><b>Met</b></span>", font_size),                                                                                     
    sprintf("<span style='color:#333333; font-size: %s'><b>PLATFORM<br></b> Technical and Infrastructure Considerations</span>", font_size),                      
    sprintf("<span style='color:#333333; font-size: %s'><b>DATA CONTRIBUTOR<br></b> Data limited to on-platform tools or remote interrogation</span>", font_size),
    sprintf("<span style='color:#333333; font-size: %s'><b>DATA CONTRIBUTOR<br></b> Researchers can access and download datasets</span>", font_size),             
    sprintf("<span style='color:#333333; font-size: %s'><b>RESEARCHER<br></b> Remote Data Interrogation</span>", font_size),                                      
    sprintf("<span style='color:#333333; font-size: %s'><b>RESEARCHER<br></b> Locked Box</span>", font_size),                                                     
    sprintf("<span style='color:#333333; font-size: %s'><b>RESEARCHER<br></b> Data Released to Researcher</span>", font_size),                                    
    sprintf("<span style='color:#333333; font-size: %s'><b>RESEARCHER<br></b> Regulatory Use</span>", font_size)
  )
  return(table_headers_html)
}

html_headers <- html_headers_fct(font_size = "12px")

#' df_original_data_fct 
#'
#' @description Create initial data to fill the assessment table
#'
#' @return summary_table_initial 
#' @noRd

df_original_data_fct <- function() {
  
  Reqs <- paste0("R", 1:39)
  
  col_names <- c(
    "Requirements",
    "Category",
    "Dimension",
    "Requirement",
    "Met",
    "Technical and Infrastructure Considerations",
    "Data limited to on-platform tools or remote interrogation",
    "Researchers can access and download datasets", 
    "Remote Data Interrogation", 
    "Locked Box", 
    "Data Released to Researcher", 
    "Regulatory Use"
  )
  
  
  Category = c("Access", "Access", "Access", "Access", "Access", "Access", "Access", 
               "Access", "Access", "Access", "Access", "Access", "Audit and Tracking", 
               "Audit and Tracking", "Audit and Tracking", "Audit and Tracking", 
               "Audit and Tracking", "Data Management", "Data Management", "Data Management", 
               "Data Management", "Infrastructure", "Infrastructure", "Infrastructure", 
               "Infrastructure", "Infrastructure", "Infrastructure", "Infrastructure", 
               "Infrastructure", "Infrastructure", "Infrastructure", "Search", "Search", "Search", "Search", "Search", 
               "Security and Privacy", "Security and Privacy", "Security and Privacy")
  
  Dimension = c("I", "G", "I", "G", "I", "I,G", "I", "I,G", "I,G", "G", "I,G", "I,G", 
                "I", "T,I", "I,G", "I", "T,I", "T,I", "T,I", "T,I", "T,I", "T", "T,I", 
                "T", "T", "T", "T", "T, I", "T,I", "T", "T", "T,I", "T,I", "T,I", "T,I", 
                "T,I,G", "T,I", "T,I,G", "T,I")
  
  Requirement = c(
    "Gated User Access",
    "Open User Access",
    "Trusted and controlled research environment",
    "Researcher access can be restricted to the Research Environment (no downloads allowed)",
    "Research environment has or allows for robust on-platform analysis tools (SAS, Python, etc.)",
    "Allows or facilitates Researcher to access multiple datasets (e.g. for cohort building) through the Research Platform",
    "Allows or facilitates on-platform Researcher use of their own licensed tools",
    "Access to view Individual Patient Data (IPD) On-Platform",
    "Access to view and work with (e.g., derive new variables) IPD On-Platform",
    "Allows for Download of Source Data (Data can be taken off platform for analysis)",
    "Allows for the enforcement of access constraints on derived data",
    "Facilitates or enables third-party access and workflows (for example, IRB or regulator access to specific datasets)",
    "Audit Trail - access to all user activity (including user activity on platform-delivered analytics tools)",
    "Allows or enables ensuring the integrity of submitted data (contributed data not changed, altered)",
    "Data Use: Attribution tracked back to Data Contributor, distinct from audit trail (through use of persistent identifiers or other mechanisms)",
    "Versioning: Maintain complete version history record of data updates, alterations, and deletions",
    "Research Environment updates or up-versioning maintain results reproducibility including traceability of previously derived results",
    "Contribution Upload Verification (ability to check required documents, data elements, file formats, etc. at trial contribution)",
    "Allows Post-Contribution Dataset Updates (e.g., to remove subjects)",
    "Enables system notifications based on administrator configured parameters, including user grouping and specific system action triggers (e.g., user notified a previously downloaded dataset has been updated)",
    "Facilitates and/or automates Data Harmonization (e.g., provides a space for Data Curation)",
    "Provides for Developer Access",
    "Data Handling: Size of upload/download datasets not limited",
    "Scalability: Ease of adding system capacity and compute capabilities (processing, memory, etc.)",
    "Platform: Delivered as a Cloud-based solution (SaaS/PaaS; does not require on-premises hardware)",
    "Contributor: Self-Service Implementation (does not require IT installation)",
    "Researcher: Self-Service Implementation (does not require IT installation)",
    "Facilitates Movement of Data Between Parties (Users, Contributors, other DSPs), through API Integrations or other means.",
    "Individual software components can be readily updated/up-versioned (e.g., upversioning a search module)",
    "Ease of external and third-party integrations",
    "Cloud-Based, does not require On-Premises Software/Hardware Installation",
    "Facilitates/Automates Data Suitability Prior to Data Request or Use (e.g., cohort discovery, context/weighting)",
    "Indexing and Search of Structured Data (e.g., indexes data domains)",
    "Indexing and Search of Unstructured Data (supporting documentation, etc.)",
    "Facilitates Metadata Collection and Representation",
    "Enables or allows for Persistent Identifiers (Digital Object Information) across data artifacts",
    "Facilitates advanced data security features (TLS Encryption, Multi-factor Authentication)",
    "Facilitates Anonymization of IPD Datasets for Contribution",
    "Supports advanced cryptography tools (for example, zero-knowledge proofs, homomorphic encryption, computational enclaves)")
  
  Met = factor(rep("Y/N", 39), levels = c("Y/N", "YES", "NO"))
  platform_1 = rep(FALSE, 39)
  data_contributor_1 = rep(FALSE, 39)
  data_contributor_2 = rep(FALSE, 39)
  researcher_1 = rep(FALSE, 39)
  researcher_2 = rep(FALSE, 39)
  researcher_3 = rep(FALSE, 39)
  researcher_4 = rep(FALSE, 39)
  
  df_original <- data.frame(
    Reqs,
    Category, 
    Dimension, 
    Requirement, 
    Met,
    platform_1, 
    data_contributor_1, 
    data_contributor_2,
    researcher_1,
    researcher_2,
    researcher_3,
    researcher_4
  )
  row.names(df_original) <- Reqs
  colnames(df_original) <- col_names
  
  return(df_original)
  
}


df_original_data <- df_original_data_fct()

usethis::use_data(intial_summary_table, html_headers, df_original_data, overwrite = TRUE, internal = TRUE)
