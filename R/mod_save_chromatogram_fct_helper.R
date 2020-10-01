save_to_file <- function(input, session, r){
  output_data <- isolate(r$raw)
  chroma_length <- r$right_edge - r$left_edge + 1
  output_data <- array(output_data[r$left_edge:r$right_edge,,1], c(chroma_length, dim(output_data)[2],1))
  save('output_data', file = 'chroma.RData')
}
