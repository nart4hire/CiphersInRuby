class CipherDataModel < AbstractModel
    attribute :input_type, :string
    attribute :plaintext_input, :text
    attribute :cipher_type, :string
    attribute :key, :text
    
    validates :input_type, presence :true, inclusion: { in: %w(text file) }
    validates :cipher_type, presence :true, inclusion: { in : %w(vigenere auto-key-vigenere extended-vigenere playfair affine hill super enigma) }
end