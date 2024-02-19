module Ciphers
    class Hill
        def initialize(key)
            @key = key
        end

        def encrypt(plaintext)
            # TODO: Implement Hill encryption algorithm
        end

        def decrypt(ciphertext)
            # TODO: Implement Hill decryption algorithm
        end

        private

        def matrix_inverse(matrix)
            # TODO: Implement matrix inverse calculation
        end

        def matrix_multiply(matrix1, matrix2)
            # TODO: Implement matrix multiplication
        end

        def pad_plaintext(plaintext)
            # TODO: Implement plaintext padding
        end

        def unpad_plaintext(padded_plaintext)
            # TODO: Implement plaintext unpadding
        end
    end
end
