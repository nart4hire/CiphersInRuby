module Utils
    module Utils
        module_function
        # TODO: create a file input handler and implement a base64 encoding
        def sanitize_input(input_text)
            return input_text.gsub(/[^a-zA-Z]/, '').downcase
        end

        # @param input_file [File]
        # @param cipher_type [String]
        # @return [String] or [Byte]
        def process_file_input(input_file, cipher_type)
            if cipher_type == 'super' or cipher_type == 'extended-vigenere'
                # append file format to the last line of file
                file_format = input_file.original_filename.split('.').last
                File.write(input_file.tempfile, "\n" + file_format, mode: 'a')
                
                # Create byte array
                byteArr = []
                File.open(input_file.tempfile, "rb") do |f|
                    f.each_byte { |byte|
                        puts byte
                        byteArr << byte
                    }
                end
                
                # Convert byte array to ASCII
                return byteArr.pack('C*')
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