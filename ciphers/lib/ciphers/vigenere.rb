module Ciphers
    module Vigenere
        module_function
        # @param [String] input_text; Sanitized input text
        # @param [String] key; Sanitized key
        # @param [Boolean] is_auto_key (default: false)
        # @return [String]
        def encrypt(input_text, key, is_auto_key = false)
            result = ""
            input_length = input_text.length
            # If the key is shorter than the input text, pad the key with the input text
            key = pad_key(input_text, key) if is_auto_key
            for i in 0..(input_length - 1)
                result += denormalize((normalize(input_text[i]) + normalize(key[i % key.length])) % 26)
            end
            return result
        end

        def decrypt(input_text, key, is_auto_key = false)
            result = ""
            input_length = input_text.length
            # If the key is shorter than the input text, pad the key with the input text
            key = pad_key(input_text, key) if is_auto_key
            for i in 0..(input_length - 1)
                result += denormalize((normalize(input_text[i]) - normalize(key[i % key.length])) % 26)
            end
            return result
        end

        def pad_key(input_text, key)
            input_length = input_text.length
            key_length = key.length
            if key_length < input_length
                padding_length = input_length - key_length
                key += input_text[..padding_length-1]
            end
            return key
        end
    end
end