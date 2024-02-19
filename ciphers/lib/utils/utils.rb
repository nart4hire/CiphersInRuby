module Utils
    module Utils
        module_function
        # TODO: create a file input handler and implement a base64 encoding
        def sanitize_input(input_text)
            return input_text.gsub(/[^a-zA-Z]/, '').downcase
        end

        # @param input_file [File]
        # @param cipher_type [String]
        # @return [String]
        def process_file_input(input_file, cipher_type)
            if cipher_type == 'super' or cipher_type == 'extended-vigenere'
                # Read each byte of the file
                File.open(input_file.tempfile) do |file|
                    file.each_byte {
                        |byte| print byte
                    }
                end
                return input_file.tempfile.read
            end
            return sanitize_input(File.read(input_file.tempfile))
        end

        # This function returns the normalized value of a downcased alphabet character in the range [0, 25]
        # @param char [String]
        # @return [Integer]
        def normalize(char)
            return char.ord - 97
        end

        # This function returns the character representation of a normalized value in the range [0, 25]
        # @param value [Integer]
        # @return [String]
        def denormalize(value)
            return (value + 97).chr
        end
    end
end