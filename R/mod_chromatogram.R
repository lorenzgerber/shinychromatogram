#' chromatogram UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_chromatogram_ui <- function(id){
  ns <- NS(id)

  click_options <- clickOpts(id = ns('clicker'), clip = TRUE)

  tagList(
    plotOutput(outputId = ns("chromatogram"), click = click_options) %>% shinycssloaders::withSpinner(color="#0dc5c1")
  )
}

#' chromatogram Server Function
#'
#' @noRd
mod_chromatogram_server <- function(input, output, session, r){
  ns <- session$ns

  observeEvent( input$clicker , {
    r$clicker_x <- input$clicker$x
  })

  output$chromatogram <- renderPlot({
    plot_data <- data.frame(signal = chromatogram::calculate_tic(r$chromatogram), scan_number = as.numeric(rownames(r$chromatogram)))
    ggplot2::ggplot(data = plot_data, ggplot2::aes(x = scan_number, y = signal)) + ggplot2::geom_line()
  })

}

## To be copied in the UI
# mod_chromatogram_ui("chromatogram_ui_1")

## To be copied in the server
# callModule(mod_chromatogram_server, "chromatogram_ui_1")

