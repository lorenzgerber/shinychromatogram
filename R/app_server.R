#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  r <- reactiveValues()
  r$spectra <- NULL
  r$raw <- NULL

  if(is.null(golem::get_golem_options(which = 'csv_data'))){
    r$raw <- r$spectra <- chromatogram::load_openchrom_csv(system.file("extdata", "oc_chromatogram_export.csv", package = "chromatogram"))
  } else {
    r$raw <- r$spectra <- chromatogram::load_openchrom_csv(golem::get_golem_options(which = 'csv_data'))
  }


  # List the first level callModules here
  callModule(mod_chromatogram_server, "chromatogram_ui_1", r)
  callModule(mod_spectra_server, "spectra_ui_1", r)
  callModule(mod_zoom_control_server, "zoom_control_ui_1", r)
  callModule(mod_save_chromatogram_server, "save_chromatogram_ui_1", r)

}
