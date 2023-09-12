

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
