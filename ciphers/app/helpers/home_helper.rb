include Utils::Utils
include Ciphers

module HomeHelper
    def self.encryptDecrypt(params)
        key = params[:key]
        if (params[:input_type] == "text")
            input_text = sanitize_input(params[:input_text])
        end
        if (params[:input_type] == "file")
            input_text = File.read(params[:input_file].tempfile)
        end

        
        case params[:cipher_type]
        when "vigenere"
            return Vigenere.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Vigenere.encrypt(input_text, key)
        end
    end
end
