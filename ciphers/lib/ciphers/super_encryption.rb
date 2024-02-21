module Ciphers
    module SuperEncryption
        module_function
        # A combination of Extended Vigenere and Columnal Transposition Cipher
        def encrypt(input_text, key)
            # Transpose the input text
            transposed_text = transpose_text_encrypt(input_text, key)
            # Encrypt the transposed text using Vigenere            
            return ExtendedVigenere.encrypt(transposed_text, key)
        end

        def decrypt(input_text, key)
            # Decrypt the input text using Vigenere
            result = ExtendedVigenere.decrypt(input_text, key)
            # Transpose the decrypted text
            return transpose_text_decrypt(result, key)
        end

        def transpose_text_encrypt(input_text, key)
            transposed_text = ""
            key_length = key.length
            for i in 0..(key_length - 1)
                current_index = i
                while current_index < input_text.length
                    transposed_text += input_text[current_index]
                    current_index += key_length
                end
            end
            return transposed_text
        end

        def transpose_text_decrypt(input_text, key)
            transposed_text = ""
            # Access it row wise
            row_length = (input_text.length.to_f / key.length).ceil
            for i in 0..(row_length - 1)
                extra_characters = input_text.length % key.length
                current_index = i
                while current_index < input_text.length && transposed_text.length < input_text.length
                    transposed_text += input_text[current_index]
                    current_index += row_length
                    if extra_characters <= 0 && !(input_text.length % key.length == 0)
                        current_index -= 1
                    end
                    extra_characters -= 1
                end
            end
            return transposed_text
        end
    end
end