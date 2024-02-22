require 'matrix'

module Ciphers
    module Hill
        module_function
        def encrypt(plaintext, key, block_size: 3, seed: 777)
            # convert plaintext to numbers
            num_plaintext = plaintext.chars.map { |c| c.ord - 'a'.ord }
            num_key = key.chars.map { |c| c.ord - 'a'.ord }

            # Pad the keys with a random seeded number between 0 and 25
            if (num_key.length < block_size * block_size)
                srand(seed)
                for i in 1..(block_size * block_size - num_key.length) do
                    num_key.append(rand(26))
                end
            end

            # create a matrix based on block_size
            matrix = num_key.each_slice(block_size).to_a

            # pad the plaintext with 'x' if the length is not a multiple of block_size
            if (num_plaintext.length % block_size != 0)
                num_plaintext += Array.new(block_size - (num_plaintext.length % block_size), 23) # x in numbers
            end

            # convert the plaintext to a matrix
            plaintext_matrix = num_plaintext.each_slice(block_size).to_a

            # multiply the plaintext matrix with the key matrix
            num_ciphertext = matrix_multiply_with_transpose(matrix, plaintext_matrix)

            # convert the numbers to characters
            ciphertext = num_ciphertext.flatten.map { |c| ((c % 26) + 'a'.ord).chr }.join

            return ciphertext
        end

        def decrypt(ciphertext, key, block_size: 3, seed: 777)
            # convert ciphertext to numbers
            num_ciphertext = ciphertext.chars.map { |c| c.ord - 'a'.ord }
            num_key = key.chars.map { |c| c.ord - 'a'.ord }

            # Pad the keys with a random seeded number between 0 and 25
            if (num_key.length < block_size * block_size)
                srand(seed)
                for i in 1..(block_size * block_size - num_key.length) do
                    num_key.append(rand(26))
                end
            end
            print num_key
            # create a matrix based on block_size
            matrix = num_key.each_slice(block_size).to_a

            # pad the plaintext with 'x' if the length is not a multiple of block_size
            if (num_ciphertext.length % block_size != 0)
                num_ciphertext += Array.new(block_size - (num_ciphertext.length % block_size), 23) # x in numbers
            end

            # convert the plaintext to a matrix
            ciphertext_matrix = num_ciphertext.each_slice(block_size).to_a

            # multiply the plaintext matrix with the inverse key matrix
            inverse_matrix = matrix_modulo_inverse(matrix)

            if (inverse_matrix == nil)
                return "Invalid key, cannot find the inverse matrix."
            end

            num_plaintext = matrix_multiply_with_transpose(inverse_matrix, ciphertext_matrix)

            # convert the numbers to characters
            plaintext = num_plaintext.flatten.map { |c| ((c % 26) + 'a'.ord).chr }.join

            return plaintext
        end

        def matrix_multiply_with_transpose(matrix1, matrix2)
            # Multiply the matrices matrix 1 with the transpose of matrix 2
            result = Array.new(matrix2.length) { Array.new(matrix1[0].length, 0) }
            for i in 0..(matrix2.length - 1)
                for j in 0..(matrix1[0].length - 1)
                    for k in 0..(matrix1[0].length - 1)
                        result[i][j] += matrix1[j][k] * matrix2[i][k]
                    end
                end
            end
            return result
        end

        def matrix_modulo_inverse(array2d)
            # if the 2darray is not square, return nil
            if (array2d.length != array2d[0].length)
                return nil
            end
            
            # convert the 2d array to a matrix
            matrix = Matrix.build(array2d.length, array2d[0].length) { |row, col| array2d[row][col] }
            det = matrix.det
            if (det == 0 || det % 2 == 0 || det % 13 == 0)
                return nil # impossible to find the inverse
            end
            
            # find the modulo inverse of the determinant
            modinvdet = 0
            for i in 1..25
                if (det * i) % 26 == 1
                    modinvdet = i
                    break
                end
            end
            
            # calculate the adjoint matrix
            adjoint_matrix = matrix.adjugate
            
            # calculate the inverse matrix
            inverse_matrix = adjoint_matrix.map { |c| (c * modinvdet) % 26 }

            return inverse_matrix.to_a
        end
    end
end
