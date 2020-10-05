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

  brush_options <- brushOpts(id = ns('super_brush'), fill = "#9cf", stroke = "#036", opacity = 0.25,
                             delay = 300, delayType = "throttle", clip = TRUE,
                             direction = "x", resetOnNew = TRUE)

  double_click_options <- dblclickOpts(id = ns('double_clicker'), clip = TRUE, delay = 400)

  tagList(
    plotOutput(outputId = ns("chromatogram"), click = click_options, brush = brush_options, dblclick = double_click_options ) %>% shinycssloaders::withSpinner(color="#0dc5c1")
  )
}

#' chromatogram Server Function
#'
#' @noRd
mod_chromatogram_server <- function(input, output, session, r){
  ns <- session$ns
  r$tic <- NULL
  r$left_edge <- NULL
  r$right_edge <- NULL

  observeEvent( input$clicker , {
    r$clicker_x <- input$clicker$x
  })

  observeEvent( input$double_clicker, {

    if(!is.null(input$super_brush$xmin)){
      upper <- dim(r$raw)[1]
      left <- round(input$super_brush$xmin,0)
      right <- round(input$super_brush$xmax, 0)
      if ( left < 1 )
        r$left_edge <- 1
      else
        r$left_edge <- left

      if ( right > upper)
        r$right_edge <- upper
      else
        r$right_edge <- right

      r$tic <- data.frame(signal = chromatogram::calculate_tic(r$raw)[r$left_edge:r$right_edge], scan_number = as.numeric(rownames(r$raw[r$left_edge:r$right_edge,,1])))
    }


  })

  output$chromatogram <- renderPlot({
    if(is.null(r$tic)){
      r$tic <- data.frame(signal = chromatogram::calculate_tic(r$raw), scan_number = as.numeric(rownames(r$raw)))
    }
    ggplot2::ggplot(data = r$tic, ggplot2::aes(x = scan_number, y = signal)) + ggplot2::geom_line()

  })

}

## To be copied in the UI
# mod_chromatogram_ui("chromatogram_ui_1")

## To be copied in the server
# callModule(mod_chromatogram_server, "chromatogram_ui_1")

