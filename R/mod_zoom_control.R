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
    textInput(ns("right_edge"), "Right Edge"),
    actionButton(ns("update_edges"), "Update Edges")
  )
}

#' zoom_control Server Function
#'
#' @noRd
mod_zoom_control_server <- function(input, output, session, r){
  ns <- session$ns

  observe({
    x <- 1
    updateTextInput(session, "left_edge", value = x)
    updateTextInput(session, "right_edge", value = round(dim(isolate(r$tic))[1],0))
  })

  observeEvent(r$left_edge, {
    updateTextInput(session, "left_edge", value = isolate(r$left_edge))
  })

  observeEvent(r$right_edge, {
    updateTextInput(session, "right_edge", value = isolate(r$right_edge))
  })

  observeEvent(input$reset_zoom, {
    r$tic <- NULL
  })

  observeEvent(input$update_edges, {
    upper <- dim(r$raw)[1]
    if(input$left_edge <= upper && input$right_edge <= upper && input$left_edge >= 1 && input$right_edge >= 1){
      r$tic <- data.frame(signal = chromatogram::calculate_tic(r$raw)[input$left_edge:input$right_edge], scan_number = as.numeric(rownames(r$raw[input$left_edge:input$right_edge,,1])))
    } else {
      shinyalert::shinyalert("Oops!", "Please select valid edges.", type = "warning")
    }
  })


}

## To be copied in the UI
# mod_zoom_control_ui("zoom_control_ui_1")

## To be copied in the server
# callModule(mod_zoom_control_server, "zoom_control_ui_1")

