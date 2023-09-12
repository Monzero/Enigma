
plug_panel_swap <- function(letter_pairs, input.matrix) {
  first_letters <- substring(letter_pairs, 1, 1)
  second_letters <- substring(letter_pairs, 2, 2)
  char.matrix    <- matrix(letters[1:26], nrow = 1)
  
  # Check for contradictory pairs
  if (any(duplicated(c(first_letters, second_letters))) || any(nchar(letter_pairs) != 2)) {
    stop("Either Contradictory pairs found or non-acceptable pair found.")
  }
  
  # Function to swap columns in the plug panel
  matrix_swap <- function(matrix, col1, col2) {
    swapped_matrix <- matrix
    swapped_matrix[, col1] <- matrix[, col2]
    swapped_matrix[, col2] <- matrix[, col1]
    return(swapped_matrix)
  }
  
  panel.matrix        <- input.matrix
  
  for( i in 1:length(letter_pairs)){
    this.pair         <- letter_pairs[i]
    col1              <- as.integer(which(char.matrix == substring(this.pair, 1, 1), arr.ind = TRUE)[, 2])
    col2              <- as.integer(which(char.matrix == substring(this.pair, 2, 2), arr.ind = TRUE)[, 2])
    panel.matrix      <- matrix_swap(panel.matrix,col1,col2)
  }
  
  return(panel.matrix)
  
  
}
