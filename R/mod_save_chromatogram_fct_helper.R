save_to_file <- function(input, session, r){
  chromatogram <- isolate(r$raw)
  if (!is.null(r$right_edge) || !is.null(r$left_edge)){
    chroma_length <- r$right_edge - r$left_edge + 1
    chromatogram <- array(chromatogram[r$left_edge:r$right_edge,,1], c(chroma_length, dim(output_data)[2],1))
  }
  save('chromatogram', file = 'chroma.RData')
}
