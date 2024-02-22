module Ciphers
    module Playfair
        module_function

        # @param [String] input_text; Sanitized input text
        # @param [String] key; Sanitized key
        # @return [String]
        def encrypt(input_text, key)
            # Remove J from key and input text
            replaced_key = key.gsub(/j/, "i")
            replaced_input_text = input_text.gsub(/j/, "i")

            # Get the key matrix
            matrix = create_key_matrix(replaced_key)

            # Find the location of duplicate characters
            input_text_clean = replaced_input_text.chars.to_a
            input_text_clean.each_with_index do |char, index|
                # Only insert the character if it is the same as the next character and the index is even (i.e. they will be paired together)
                if char == input_text_clean[index + 1] && index % 2 == 0
                    # If the character is x, insert a z after it
                    if char == 'x'
                        input_text_clean.insert(index + 1, 'z')
                    # If the character is not x, insert an x after it
                    else
                        input_text_clean.insert(index + 1, 'x')
                    end
                end
            end

            # If the length of the input text is odd, add an x to the end
            input_text_clean.push('x') if input_text_clean.length.odd?

            # Pair the characters together and encrypt them
            encrypted_text = process_string(matrix, input_text_clean)

            return encrypted_text
        end

        # @param [String] input_text; Sanitized input text
        # @param [String] key; Sanitized key
        # @return [String]
        def decrypt(input_text, key)
            # Remove J from key and input text
            replaced_key = key.gsub(/j/, "i")
            replaced_input_text = input_text.gsub(/j/, "i")

            # Get the key matrix
            matrix = create_key_matrix(replaced_key)

            # Find the location of duplicate characters
            input_text_clean = replaced_input_text.chars.to_a

            # Pair the characters together and decrypt them
            decrypted_text = process_string(matrix, input_text_clean, encrypt: false)

            return decrypted_text
        end

        # @param [String] key; Sanitized key
        # @return [Array<Array<String>>] key_matrix
        def create_key_matrix(key)
            # Turn the key into a set of unique characters
            key_set = key.chars.to_a.uniq

            # Create a 5x5 matrix
            key_matrix = Array.new(5) { Array.new(5) }

            # Fill the matrix with the key
            row = 0
            col = 0
            key_set.join.each_char do |char|
                if col == 5
                    col = 0
                    row += 1
                end
                key_matrix[row][col] = char
                col += 1
            end

            # Fill the matrix with the remaining characters
            ('a'..'z').each do |char|
                next if char == 'j'
                next if key_set.include?(char)
                if col == 5
                    col = 0
                    row += 1
                end
                key_matrix[row][col] = char
                col += 1
            end

            return key_matrix
        end

        # Process string template for encryption and decryption
        # @param [Array<Array<String>>] key_matrix; Key matrix
        # @param [String] text_clean; Input text
        # @param [Boolean] encrypt; Indicator for encryption (default: true)
        # @return [String] Encrypted or decrypted text
        def process_string(key_matrix, text_clean, encrypt: true)
            # Pair the characters together and process them
            processed_text = ""
            text_clean.each_slice(2) do |pair|
                # Find the position of the characters in the matrix
                index1 = key_matrix.flatten.index(pair[0])
                index2 = key_matrix.flatten.index(pair[1])
                row1, col1 = index1.divmod(5)
                row2, col2 = index2.divmod(5)

                if encrypt
                    # Encryption logic
                    if row1 == row2
                        processed_text += key_matrix[row1][(col1 + 1) % 5]
                        processed_text += key_matrix[row2][(col2 + 1) % 5]
                    elsif col1 == col2
                        processed_text += key_matrix[(row1 + 1) % 5][col1]
                        processed_text += key_matrix[(row2 + 1) % 5][col2]
                    else
                        processed_text += key_matrix[row1][col2]
                        processed_text += key_matrix[row2][col1]
                    end
                else
                    # Decryption logic
                    if row1 == row2
                        processed_text += key_matrix[row1][(col1 - 1) % 5]
                        processed_text += key_matrix[row2][(col2 - 1) % 5]
                    elsif col1 == col2
                        processed_text += key_matrix[(row1 - 1) % 5][col1]
                        processed_text += key_matrix[(row2 - 1) % 5][col2]
                    else
                        processed_text += key_matrix[row1][col2]
                        processed_text += key_matrix[row2][col1]
                    end
                end
            end

            if !encrypt
                # Remove any trailing 'x' characters
                processed_text.gsub!(/x+$/, '')
            end

            return processed_text
        end
    end
end