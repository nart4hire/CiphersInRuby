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
