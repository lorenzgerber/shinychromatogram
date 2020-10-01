#' zoom_control UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_zoom_control_ui <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(ns("reset_zoom"), "Reset Zoom")
  )
}

#' zoom_control Server Function
#'
#' @noRd
mod_zoom_control_server <- function(input, output, session, r){
  ns <- session$ns

  observeEvent(input$reset_zoom, {
    r$tic <- NULL
  })

}

## To be copied in the UI
# mod_zoom_control_ui("zoom_control_ui_1")

## To be copied in the server
# callModule(mod_zoom_control_server, "zoom_control_ui_1")

