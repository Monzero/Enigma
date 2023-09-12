library(data.table)

enigma.functions.folder          <- 'C:/Users/Monil/OneDrive/Documents/R/Enigma/01_Functions/'
list.enigma.functions            <- paste0(enigma.functions.folder,list.files(enigma.functions.folder))

sapply(list.enigma.functions[1],source)

# Setting Initial values
machine_setting <- list(
  rotor1 = list(initial_pos = 23, ring_pos = 22),
  rotor2 = list(initial_pos = 2, ring_pos = 22),
  rotor3 = list(initial_pos = 3, ring_pos = 22)
  
)


letter_pairs                      = c('ab','cd','gh','kl')

# Initialize rotor matrices
rotor_matrices                    <- lapply(machine_setting, function(rotor) { rotate_rotor(diag(26), rotor$initial_pos)})

# Set up plug panel 
plug_panel                        <- plug_panel_swap(letter_pairs,diag(26))




