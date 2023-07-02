# Enigma
This is Matrix representation of famous encryption machine called 'Enigma'

# Enigma Machine Replica

This repository contains an implementation of the Enigma machine replica for encryption in R.

The Enigma machine was a complex encryption device used during World War II for secure communication. This replica aims to simulate the functionality of the Enigma machine, allowing you to encrypt messages using its rotor system and reflector.

## Table of Contents

- [Features](#features)
- [Usage](#usage)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Features

- Simulation of the Enigma machine rotor system and reflector.
- Ability to set the initial positions and ring positions of the rotors.
- Plugboard functionality for swapping letters.
- Supports encryption of alphabetic characters while preserving non-alphabetic characters.

## Usage

1. Clone the repository to your local machine:

2. Navigate to the cloned directory:

3. Run the `enigma_machine.R` script in R:

4. Modify the script as needed to set up your desired rotor settings and plugboard swaps.

5. Use the `encrypt_sentence` function to encrypt your messages:

```R
sentence <- "Hello, World!"
encrypted_sentence <- encrypt_sentence(sentence)
cat("Encrypted sentence:", encrypted_sentence)

Feel free to customize this README file based on your specific implementation and requirements. Provide instructions on how to use the code, examples of its usage, and guidelines for contributions. Also, make sure to update the license information accordingly.
Remember to include any additional sections or information that you think would be valuable for users of your Enigma machine replica.
