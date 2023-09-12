# Core encoding function
encode_enigma_core <- function(letter) {
  row_number                     <- match(tolower(letter), letters)
  chosen_letter                  <- get_chosen_letter(row_number) %*% plug_panel
  
  # Rotate rotors
  rotor_matrices[["rotor1"]]     <- rotate_rotor(rotor_matrices[["rotor1"]], 1)
  
  if (get_rotation_count(rotor_matrices[["rotor1"]]) == machine_setting$rotor1$initial_pos) {
    rotor_matrices[["rotor2"]] <- rotate_rotor(rotor_matrices[["rotor2"]], 1)
  }
  
  if (get_rotation_count(rotor_matrices[["rotor2"]]) == machine_setting$rotor2$initial_pos) {
    rotor_matrices[["rotor3"]] <- rotate_rotor(rotor_matrices[["rotor3"]], 1)
  }
  
  chosen_letter                 <- chosen_letter %*% rotor_matrices[["rotor1"]]
  chosen_letter                 <- chosen_letter %*% rotor_matrices[["rotor2"]]
  chosen_letter                 <- chosen_letter %*% rotor_matrices[["rotor3"]]
  
  # Reflect
  reflected_letter                <- reflector(letters[which(chosen_letter == 1)])
  
  # Back loop
  row_number                      <- match(tolower(reflected_letter), letters)
  chosen_letter                   <- get_chosen_letter(row_number) %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor3"]]), FALSE)
  chosen_letter                   <- chosen_letter %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor2"]]), FALSE)
  chosen_letter                   <- chosen_letter %*% rotate_rotor(diag(26), get_rotation_count(rotor_matrices[["rotor1"]]), FALSE)
  
  chosen_letter                   <- chosen_letter %*% plug_panel
  
  return(letters[which(chosen_letter == 1)])
}
