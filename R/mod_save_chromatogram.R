#' save_chromatogram UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_save_chromatogram_ui <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(ns("save_chromatogram"), "Save Chromatogram Segment")
  )
}

#' save_chromatogram Server Function
#'
#' @noRd
mod_save_chromatogram_server <- function(input, output, session, r){
  ns <- session$ns

  observeEvent(input$save_chromatogram, {
    browser()
    save_to_file(input, session, r)
  })

}

## To be copied in the UI
# mod_save_chromatogram_ui("save_chromatogram_ui_1")

## To be copied in the server
# callModule(mod_save_chromatogram_server, "save_chromatogram_ui_1")

