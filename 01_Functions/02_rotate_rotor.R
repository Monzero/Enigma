
# Function to rotate the rotor matrix
rotate_rotor <- function(matrix, n, clockwise = TRUE) {
  num_columns <- ncol(matrix)
  if (n > 0) {
    if (clockwise) {
      rotated_matrix <- matrix[, c((num_columns - n + 1):num_columns, 1:(num_columns - n))]
    } else {
      rotated_matrix <- matrix[, c((n + 1):num_columns, 1:n)]
    }
  } else {
    rotated_matrix <- matrix
  }
  
  return(rotated_matrix)
}
