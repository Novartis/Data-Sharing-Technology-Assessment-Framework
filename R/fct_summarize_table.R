
#' summarize_table 
#'
#' @description Creates summary table from the data retrieved from the assessment
#' table
#'
#' @return summary_table
#' @param data original complete data
#' @param selected_filter how you want to filter the table
#' @export
summarize_table <- function(data, selected_filter) {
  
  views = list(
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
  
  if (!(is.null(data))) {
    
    if (selected_filter %in% views[["By category"]]) {
      summary_table <- by_category(data, selected_filter)
      
    } else if (selected_filter %in% views[["By Use Case"]]) {
      summary_table <- by_use_case(data, selected_filter)
    }
    
  } else {
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
    summary_table <- data.frame(
      c1 = rep(0, 4),
      c2 = rep(0, 4),
      c3 = rep(0, 4),
      c4 = rep(0, 4),
      c5 = rep(0, 4),
      c6 = rep(0, 4),
      c7 = rep(0, 4)
    )
    row.names(summary_table) <- c("In Scope", "Met", "Not Met", "Summary")
    colnames(summary_table) <- cols_with_info[2:8]
  }
  
  return(summary_table)
  
}

#' by_category 
#'
#' @description helper function that summarizes the assessment table by category
#'
#' @param data original complete data
#' @param selected_filter how you want to filter the table
#' @return end_table
#' @export
by_category <- function(data, selected_filter) {
  
  cols_with_info <- c(
    "Technical and Infrastructure Considerations",
    "Data limited to on-platform tools or remote interrogation",
    "Researchers can access and download datasets", 
    "Remote Data Interrogation", 
    "Locked Box", 
    "Data Released to Researcher", 
    "Regulatory Use"
  )
  
  # If All categories, we leave the table as it is
  if (!(selected_filter == "All categories"))  {
    data <- data %>%
      dplyr::filter(
        .data$Category == selected_filter
      )
  }
  
  # Make it easier for computations [YES:1 NO:0 other:NA]
  data$Met <- ifelse(data$Met == "YES", 1, ifelse(data$Met == "NO", 0, NA))
  
  numeric_data <- data[cols_with_info]
  numeric_data <- sapply(
    numeric_data, FUN=as.integer
  )
  
  met <- data["Met"]
  met <- sapply(
    met, FUN=as.integer
  )
  
  row_sum_numeric_data <- rowSums(numeric_data, na.rm=TRUE)
  data_4_not_answered <- data.frame(
    Met=met, 
    row_sums=row_sum_numeric_data
  ) 
  
  condition_not_answered <- data_4_not_answered$row_sums > 0 & is.na(data_4_not_answered$Met)
  data_4_not_answered$Met <- ifelse(condition_not_answered,"not_answered", data_4_not_answered$Met)
  
  not_answered <- data.frame(
    data_4_not_answered$Met,
    numeric_data
    ) %>%
    dplyr::filter(
      data_4_not_answered.Met == "not_answered"
    ) %>%
    select(
      -data_4_not_answered.Met
    ) %>%
    colSums()
  
  in_scope <- colSums(numeric_data, na.rm=TRUE)
  in_scope_real <- in_scope - as.vector(not_answered)
  
  numeric_data_bis <- as.vector(met) * numeric_data
  met_total <- colSums(numeric_data_bis, na.rm=TRUE)
  
  percentages <- (met_total/in_scope_real) * 100
  percentages <- tidyr::replace_na(percentages, 0)
  
  end_table <- data.frame(platform_1 = numeric(), 
                          data_contributor_1 = numeric(), 
                          data_contributor_2 = numeric(),
                          researcher_1 = numeric(),
                          researcher_2 = numeric(),
                          researcher_3 = numeric(),
                          researcher_4 = numeric()
  )
  
  
  end_table[1, ] <- in_scope
  end_table[2, ] <- met_total
  end_table[3, ] <- in_scope_real - met_total
  end_table[4, ] <- as.vector(not_answered)
  end_table[5, ] <- percentages
  
  colnames(end_table) <- cols_with_info
  row.names(end_table) <- c("In Scope", "Met", "Not Met", "Not answered", "Summary")
  
  return(end_table)
}


#' by_use_case 
#'
#' @description helper function that summarizes the assessment table by use case
#'
#' @param data original complete data
#' @param selected_filter how you want to filter the table
#' @return end_table
#'
#' @export
by_use_case <- function(data, selected_filter) {
  
  all_categories <- c(
    "Access", 
    "Audit and Tracking", 
    "Data Management", 
    "Infrastructure", 
    "Search", 
    "Security and Privacy"
  )
  
  cols_with_info <- c(
    "Technical and Infrastructure Considerations",
    "Data limited to on-platform tools or remote interrogation",
    "Researchers can access and download datasets", 
    "Remote Data Interrogation", 
    "Locked Box", 
    "Data Released to Researcher", 
    "Regulatory Use"
  )
  
  # Make it easier for computations [YES:1 NO:0 other:NA]
  data$Met <- ifelse(data$Met == "YES", 1, ifelse(data$Met == "NO", 0, NA))

  data$Met <- sapply(
    data$Met, FUN=as.integer
  )
  
  data[cols_with_info] <- sapply(
    data[cols_with_info], FUN=as.integer
  )
  
  if (!(selected_filter == "All Use Cases"))  {
    cols <- c("Category", "Met", selected_filter)
    assessment_data <- data[cols] 
  } else {
    cols <- c(cols_with_info, "Category", "Met")
    assessment_data <- data[cols]
    
  }
  
  end_list <- vector(mode = "list")
  
  for (cat in all_categories) {
    
    data_subset <- assessment_data %>%
      dplyr::filter(
        .data$Category == cat
      )
    
    met <- data_subset["Met"]
    
    
    if (!(selected_filter == "All Use Cases"))  {
      numeric_data <- data_subset[selected_filter] %>%
        rowSums(na.rm = TRUE) %>%
        data.frame()
    } else {
      numeric_data <- data_subset[cols_with_info] %>%
        rowSums(na.rm = TRUE) %>%
        data.frame()
    }
    
    data_4_not_answered <- data.frame(
      Met=met, 
      row_sums=numeric_data
    ) 
    colnames(data_4_not_answered) <- c("Met", "row_sums")
    
    condition_not_answered <- data_4_not_answered$row_sums > 0 & is.na(data_4_not_answered$Met)

    data_4_not_answered$Met <- ifelse(condition_not_answered,"not_answered", data_4_not_answered$Met)
    
    not_answered <- data.frame(
      data_4_not_answered$Met,
      numeric_data
      ) %>%
      dplyr::filter(
        data_4_not_answered.Met == "not_answered"
      ) %>%
      select(
        -data_4_not_answered.Met
      ) %>%
      colSums(na.rm = TRUE)
    
    
    in_scope <- numeric_data %>%
      colSums(na.rm = TRUE)
    in_scope_real <- in_scope - as.vector(not_answered)
    
    numeric_data_bis <- as.vector(met) * numeric_data
    
    met_total <- numeric_data_bis %>%
      colSums(na.rm = TRUE)
    
    not_met <- in_scope_real - met_total
    percentage <- (met_total/in_scope_real) * 100
    percentage <- tidyr::replace_na(percentage, 0)
    
    data_current_cat <- rbind(in_scope, met_total, not_met, not_answered, percentage) %>%
      as.matrix()
    
    end_list[[cat]] <- data_current_cat
  }
  
  end_table <- do.call(data.frame, end_list)
  
  row.names(end_table) <- c("In Scope", "Met", "Not Met", "Not answered", "Summary")
  colnames(end_table) <- all_categories
  
  return(end_table)
}

