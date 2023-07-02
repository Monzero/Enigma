# Enigma Machine Replica Encryption

# Setting Initial values
machine_setting <- list(
  rotor1 = list(initial_pos = 23, ring_pos = 22),
  rotor2 = list(initial_pos = 2, ring_pos = 22),
  rotor3 = list(initial_pos = 3, ring_pos = 22)

)

# Function to create a matrix for the chosen letter
get_chosen_letter <- function(n) {
  matrix(c(rep(0, n - 1), 1, rep(0, 26 - n)), nrow = 1, ncol = 26)
}

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

# Function to get the rotation count
get_rotation_count <- function(rotated_matrix) {
  rotation_amount <- which(rotated_matrix[1, ] == 1) - 1
  return(rotation_amount)
}

# Reflector function
reflector <- function(letter) {
  mapping <- c(
    "a" = "y", "b" = "r", "c" = "u", "d" = "h", "e" = "q", "f" = "s", "g" = "l", "h" = "d",
    "i" = "p", "j" = "x", "k" = "n", "l" = "g", "m" = "o", "n" = "k", "o" = "m", "p" = "i",
    "q" = "e", "r" = "b", "s" = "f", "t" = "z", "u" = "c", "v" = "w", "w" = "v", "x" = "j",
    "y" = "a", "z" = "t"
  )
  if (letter %in% names(mapping)) {
    return(mapping[letter])
  } else {
    return(letter)
  }
}

plug_panel_swap <- function(letter_pairs, input.matrix) {
  first_letters <- substring(letter_pairs, 1, 1)
  second_letters <- substring(letter_pairs, 2, 2)
  
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
    col1              <- as.integer(which(char.matrix == substring(this.pair, 1, 1), arr.ind = TRUE)[, 1])
    col2              <- as.integer(which(char.matrix == substring(this.pair, 2, 2), arr.ind = TRUE)[, 1])
    panel.matrix      <- matrix_swap(panel.matrix,col1,col2)
  }
  
  return(panel.matrix)
  
  
}

# Core encoding function
encode_enigma_core <- function(letter) {
  row_number <- match(tolower(letter), letters)
  chosen_letter <- get_chosen_letter(row_number) %*% plug_panel
  
  # Rotate rotors
  rotor_matrices[["rotor1"]] <- rotate_rotor(rotor_matrices[["rotor1"]], 1)
  
  if (get_rotation_count(rotor_matrices[["rotor1"]]) == machine_setting$rotor1$initial_pos) {
    rotor_matrices[["rotor2"]] <- rotate_rotor(rotor_matrices[["rotor2"]], 1)
  }
  
  if (get_rotation_count(rotor_matrices[["rotor2"]]) == machine_setting$rotor2$initial_pos) {
    rotor_matrices[["rotor3"]] <- rotate_rotor(rotor_matrices[["rotor3"]], 1)
  }
  
  chosen_letter <- chosen_letter %*% rotor_matrices[["rotor1"]]
  chosen_letter <- chosen_letter %*% rotor_matrices[["rotor2"]]
  chosen_letter <- chosen_letter %*% rotor_matrices[["rotor3"]]
  
  # Reflect
  reflected_letter <- reflector(letters[which(chosen_letter == 1)])
  
  # Back loop
  row_number <- match(tolower(reflected_letter), letters)
  chosen_letter <- get_chosen_letter(row_number) %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor3"]]), FALSE)
  chosen_letter <- chosen_letter %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor2"]]), FALSE)
  chosen_letter <- chosen_letter %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor1"]]), FALSE)
  
  chosen_letter <- chosen_letter %*% plug_panel
  
  return(letters[which(chosen_letter == 1)])
}


# Encrypt a sentence using the Enigma machine replica
encrypt_sentence <- function(sentence) {
  encrypted_letters <- character()
  
  for (letter in strsplit(sentence, "")[[1]]) {
    if (grepl("[A-Za-z]", letter)) {
      if (toupper(letter) == letter) {
        # Convert uppercase letter to lowercase
        encrypted_letter <- toupper(encode_enigma_core(tolower(letter)))
      } else {
        # Lowercase letter, pass to encode_enigma_core directly
        encrypted_letter <- encode_enigma_core(letter)
      }
    } else {
      # Non-alphabetic character, append to output string directly
      encrypted_letter <- letter
    }
    
    encrypted_letters <- c(encrypted_letters, encrypted_letter)
  }
  
  encrypted_sentence <- paste(encrypted_letters, collapse = "")
  return(encrypted_sentence)
}

##########################################################################################
#######   Script                                                                   ######
##########################################################################################

letter_pairs = c('ab','cd','gh','kl')

# Initialize rotor matrices
rotor_matrices <- lapply(machine_setting, function(rotor) {
  rotate_rotor(diag(26), rotor$initial_pos)
})

# Set up plug panel 
plug_panel <- plug_panel_swap(machine_setting$letter_pairs,diag(26))


# Encrypt a sample sentence
sentence_to_encrypt <- "Fjlr kxldbo bozjlxk lr uaselxd tlxk!"
encrypted_sentence <- encrypt_sentence(sentence_to_encrypt)

print(encrypted_sentence)



