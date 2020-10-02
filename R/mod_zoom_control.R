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
    actionButton(ns("reset_zoom"), "Reset Zoom"),
    textInput(ns("left_edge"), "Left Edge"),
    textInput(ns("right_edge"), "Right Edge")
  )
}

#' zoom_control Server Function
#'
#' @noRd
mod_zoom_control_server <- function(input, output, session, r){
  ns <- session$ns

  observeEvent(r$left_edge, {
    updateTextInput(session, "left_edge", value = isolate(r$left_edge))
  })

  observeEvent(r$right_edge, {
    updateTextInput(session, "right_edge", value = isolate(r$right_edge))
  })

  observeEvent(input$reset_zoom, {
    r$tic <- NULL
  })

}

## To be copied in the UI
# mod_zoom_control_ui("zoom_control_ui_1")

## To be copied in the server
# callModule(mod_zoom_control_server, "zoom_control_ui_1")

