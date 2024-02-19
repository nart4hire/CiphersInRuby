include Utils::Utils
include Ciphers

module HomeHelper
    def self.encryptDecrypt(params)
        key = params[:key]
        if (!(params[:cipher_type] == 'super' or params[:cipher_type] == 'extended-vigenere'))
            key = sanitize_input(key)
        end

        if (params[:input_type] == "text")
            input_text = sanitize_input(params[:input_text])
        elsif (params[:input_type] == "file")
            input_text = process_file_input(params[:input_file], params[:cipher_type])
            print input_text
        end

        
        case params[:cipher_type]
        when "vigenere"
            return Ciphers::Vigenere.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Vigenere.encrypt(input_text, key)
        when "auto-key-vigenere"
            return Ciphers::Vigenere.decrypt(input_text, key, true) if params[:commit] == "Decrypt"
            return Ciphers::Vigenere.encrypt(input_text, key, true)
        end
    end
end
