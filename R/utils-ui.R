generate_color_documentation <- function(colors) {
  items <- unlist(lapply(colors, rd_color_tag))
  paste0("\\itemize{", paste0(items, "\n", collapse =""), "}")
}

#' Valid statuses
#'
#' These status strings correspond to colors as defined in Bootstrap's CSS.
#' Although the colors can vary depending on the particular CSS selector, they
#' generally appear as follows:
#'
#' `r generate_color_documentation(c("primary", "secondary", "success", "info", "warning", "danger"))`
#'
#' @usage NULL
#' @format NULL
#'
#' @keywords internal
validStatuses <- c(
  "primary",
  "secondary",
  "success",
  "info",
  "warning",
  "danger",
  "dark",
  "light"
)

# Returns TRUE if a status is valid; throws error otherwise.
validateStatus <- function(status) {
  if (status %in% validStatuses) {
    return(TRUE)
  }
  
  stop(
    "Invalid status: ", status, ". Valid statuses are: ",
    paste(validStatuses, collapse = ", "), "."
  )
}


custom_jumbotron <- function(..., title = NULL, lead = NULL, href = NULL, btnName = "More",
                             status = "dark") {
  if (!is.null(status)) validateStatus(status)
  
  if (status == "dark") btnStatus <- "secondary" else btnStatus <- "dark"
  
  jumboCl <- "mt-2 p-3 text-white rounded"
  if (!is.null(status)) jumboCl <- paste0(jumboCl, " bg-", status)
  
  # no need to wrap this tag in an external div to set a custom width
  # since the jumbotron will take the whole page width
  tags$div(
    class = jumboCl,
    if (!is.null(btnName)) {
      div(
        class = "d-flex justify-content-end",
        tags$a(
          class = paste0("btn btn-", btnStatus, " btn-sm"),
          href = href,
          target = "_blank",
          role = "button",
          btnName
        )
      )
    },
    tags$h2(class = "display-4", title, style = "font-size: 2.5rem"),
    tags$p(class = "font-weight: 200; fond-size: 1.1rem", lead),
    tags$p(...)
  )
}


popover <- function(tag, content, title, placement = c("top", "bottom", "left", "right")) {
  placement <- match.arg(placement)
  
  tag <- shiny::tagAppendAttributes(
    tag,
    `data-bs-container` = "body",
    `data-bs-toggle` = "popover",
    `data-bs-placement` = placement,
    `data-bs-content` = content,
    `data-bs-trigger` = "hover",
    title = title
  )
  
  tagId <- tag$attribs$id
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(
          sprintf(
            "$(function () {
              // enable popover
              $('#%s').popover();
            });
            ",
            tagId
          )
        )
      )
    ),
    tag
  )
}


badge <- function(id, text, color = validStatuses, ...) {
  color <- match.arg(color)
  badge_cl <- sprintf(
    "badge bg-%s",
    color
  )
  tags$span(class =  badge_cl, text, id = id, ...)
}


tooltip <- function(tag, title, placement = c("top", "bottom", "left", "right")) {
  placement <- match.arg(placement)
  
  tag <- shiny::tagAppendAttributes(
    tag,
    `data-bs-toggle` = "tooltip",
    `data-bs-placement` = placement,
    title = title
  )
  
  tagId <- tag$attribs$id
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(
          sprintf(
            "$(function () {
              // enable tooltip
              $('#%s').tooltip();
            });
            ",
            tagId
          )
        )
      )
    ),
    tag
  )
}

centered_item <- function(tag) {
  layout_columns(
    col_widths = c(-5, 2, -5),
    tag
  )
}
