module Ciphers
    module ExtendedVigenere
        module_function
        def encrypt(input_text, key)
            result = ""
            input_length = input_text.length
            key_length = key.length
            for i in 0..(input_length - 1)
                result += ((input_text[i].ord + key[i % key_length].ord) % 256).chr
            end
            return result
        end
        
        def decrypt(input_text, key)
            result = ""
            input_length = input_text.length
            key_length = key.length
            for i in 0..(input_length - 1)
                result += ((input_text[i].ord - key[i % key_length].ord) % 256).chr
            end
            return result
        end
    end
end