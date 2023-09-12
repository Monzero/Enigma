# Function to create a matrix for the chosen letter
get_chosen_letter <- function(n) {
  matrix(c(rep(0, n - 1), 1, rep(0, 26 - n)), nrow = 1, ncol = 26)
}