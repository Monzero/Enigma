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