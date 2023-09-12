# Function to get the rotation count
get_rotation_count <- function(rotated_matrix) {
  rotation_amount <- which(rotated_matrix[1, ] == 1) - 1
  return(rotation_amount)
}
