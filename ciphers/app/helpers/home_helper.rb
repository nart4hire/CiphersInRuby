include Utils::Utils
include Ciphers

module HomeHelper
    def self.encryptDecrypt(params)
        key = params[:key]
        input_text = params[:input_text]
        if (!(params[:cipher_type] == 'super' or params[:cipher_type] == 'extended-vigenere'))
            key = sanitize_input(key)
        end
        if (params[:input_type] == "text" and !(params[:cipher_type] == 'super' or params[:cipher_type] == 'extended-vigenere'))
            input_text = sanitize_input(params[:input_text])
        elsif (params[:input_type] == "file")
            input_text = process_file_input(params[:input_file], params[:cipher_type], params[:commit] == "Decrypt")
        end

        
        case params[:cipher_type]
        when "vigenere"
            return Ciphers::Vigenere.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Vigenere.encrypt(input_text, key)
        when "auto-key-vigenere"
            return Ciphers::Vigenere.decrypt(input_text, key, true) if params[:commit] == "Decrypt"
            return Ciphers::Vigenere.encrypt(input_text, key, true)
        when "playfair"
            return Ciphers::Playfair.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Playfair.encrypt(input_text, key)
        when "affine"
            return Ciphers::Affine.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Affine.encrypt(input_text, key)
        when "hill"
            return Ciphers::Hill.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Hill.encrypt(input_text, key)
        when "enigma"
            return Ciphers::Enigma.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::Enigma.encrypt(input_text, key)
        when "extended-vigenere"
            return Ciphers::ExtendedVigenere.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::ExtendedVigenere.encrypt(input_text, key)
        when "super"
            return Ciphers::SuperEncryption.decrypt(input_text, key) if params[:commit] == "Decrypt"
            return Ciphers::SuperEncryption.encrypt(input_text, key)
        end
    end
end
