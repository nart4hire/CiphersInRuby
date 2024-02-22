# Affine cipher implementation
module Ciphers
    module Affine
        module_function
        def encrypt(plaintext, key)
            # convert plaintext to numbers
            num_plaintext = plaintext.chars.map { |c| c.ord - 'a'.ord }
            num_key = key.chars.map { |c| c.ord - 'a'.ord }

            # check if the "a" key is valid, if not, set it to 3
            if (num_key[0].gcd(26) != 1)
                num_key[0] = 3
            end

            # calculate the affine cipher
            num_ciphertext = num_plaintext.map { |c| (num_key[0] * c + num_key[1]) % 26 }
            ciphertext = num_ciphertext.map { |c| (c + 'a'.ord).chr }.join

            return ciphertext
        end

        def decrypt(ciphertext, key)
            # convert ciphertext to numbers
            num_ciphertext = ciphertext.chars.map { |c| c.ord - 'a'.ord }
            num_key = key.chars.map { |c| c.ord - 'a'.ord }

            # check if the "a" key is valid, if not, set it to 3
            if (num_key[0].gcd(26) != 1)
                num_key[0] = 3
            end

            # calculate the inverse of the "a" key
            inverse_a = 0
            (0..25).each do |i|
                if (i * num_key[0] % 26 == 1)
                    inverse_a = i
                    break
                end
            end

            # calculate the decrypted plaintext
            num_plaintext = num_ciphertext.map { |c| (inverse_a * (c - num_key[1])) % 26 }
            plaintext = num_plaintext.map { |c| (c + 'a'.ord).chr }.join

            return plaintext
        end
    end
end