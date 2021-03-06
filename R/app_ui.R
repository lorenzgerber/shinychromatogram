#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    fluidPage(
      titlePanel("Chromatogram Viewer"),
      mod_chromatogram_ui("chromatogram_ui_1"),
      hr(),
      fluidRow(
        column(4,
               h3("Mass Spectra"),
               mod_spectra_ui("spectra_ui_1")
               ),
        column(4,
               h3("Zoom Control"),
               mod_zoom_control_ui("zoom_control_ui_1")
               ),
        column(4,
               h3("Save Data"),
               mod_save_chromatogram_ui("save_chromatogram_ui_1")
               )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinychromatogram'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

