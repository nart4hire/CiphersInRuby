# CiphersInRuby
An Implementation of a few popular **Breakable Ciphers** in **Ruby**.

---

## Implementation Details
This implementation uses **Docker** and the **Compose** utility to easily run the services below:
- Ruby on Rails
- Sidekiq
- Nginx

Requirements:
- Docker: Latest
- Docker Compose: Latest

Tested On:
- Windows
- Ubuntu 22.04

---

## Running
To run this application locally, run this command in the repository directory:
```sh
> docker compose up
```

Alternatively you can see a live demo [here](#TODO)

---

## Ciphers
Below is the list of ciphers implemented:
- **Alphabet** (*26 Letters*):
  - Vigenere Cipher
  - Auto-Key Vigenere Cipher
  - Playfair Cipher
  - Affine Cipher
  - Hill Cipher
  - Enigma Cipher
- **ASCII** (*256 Characters*):
  - Extended Vigenere Cipher
  - Extended Vigenere Cipher with transposition

---

## Misc
- The model used for the Enigma Cipher is the ["Enigma I"](https://www.cryptomuseum.com/crypto/enigma/wiring.htm) using rotors I, II, and III and reflector UKW-B
- The notch is calculated using the turnover stated on the site as it is easier to get the value of the window compared to the physical position of the notch.
- The rotor positions are calculated using the sum of representation numbers in the plugboard e.x. if the plugboard is "ab", then the seed is 1 and the random value will thus be 5, 11, and 12 which will be the position of the rotors initially`
- The rotors will be activated in the order `rotor3 -> rotor2 -> rotor1 -> reflector -> rotor1 -> rotor2 -> rotor3`