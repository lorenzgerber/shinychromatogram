#' spectra UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_spectra_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(outputId = ns("spectra"))
  )
}

#' spectra Server Function
#'
#' @noRd
mod_spectra_server <- function(input, output, session, r){
  ns <- session$ns
  output$spectra <- renderPlot({
    if(!is.null(r$clicker_x))({
      barplot(r$spectra[round(r$clicker_x, 0),,1])
    })
  })

}

## To be copied in the UI
# mod_spectra_ui("spectra_ui_1")

## To be copied in the server
# callModule(mod_spectra_server, "spectra_ui_1")

