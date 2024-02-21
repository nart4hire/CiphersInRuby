class Enigma
    @@pos_rotor1 = 0
    @@pos_rotor2 = 0
    @@pos_rotor3 = 0

    def encrypt(plaintext, key)
        # Using the plugboard key, get a seed value
        seed = key.chars.map { |c| c.ord - 'a'.ord }.sum
        srand(seed)

        # randomize the rotor positions
        @@pos_rotor1 = rand(26)
        @@pos_rotor2 = rand(26)
        @@pos_rotor3 = rand(26)

        # create a hash for the plugboard using key
        plugboard = Hash.new
        key.chars.each_slice(2) do |pair|
            plugboard[pair[0]] = pair[1]
            plugboard[pair[1]] = pair[0]
        end

        # encrypt the plaintext using the plugboard
        plaintext = plaintext.chars.map { |c| plugboard[c] ? plugboard[c] : c }.join

        # encrypt the plaintext using the rotors
        plaintext = plaintext.chars.map { |c| rotor3(c) }.join

        # encrypt the plaintext using the plugboard a second time
        plaintext = plaintext.chars.map { |c| plugboard[c] ? plugboard[c] : c }.join

        return plaintext
    end

    def decrypt(ciphertext, key)
        # since the cipher is symmetric, we can use the same method to encrypt and decrypt
        ciphertext = encrypt(ciphertext, key)

        return ciphertext
    end

    def rotor3(char, reverse: false)
        # Initialize the rotor
        encrypt_string = "bdfhjlcprtxvznyeiwgakmusqo"
        encrypt_num = encrypt_string.chars.map { |c| c.ord - 'a'.ord }
        notch = "v"
        rotor = Hash.new
    
        for i in 0..25 do
            rotor[i] = encrypt_num[i]
        end
    
        if reverse
            rotor = rotor.invert
    
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor3) % 26] + 26 - @@pos_rotor3) % 26 + 'a'.ord).chr
    
            # Then return the result
            return result
        else
            rotate_next = false
            if @@pos_rotor3 == (notch.ord - 'a'.ord)
                # Rotate the second rotor
                rotate_next = true
            end
        
            # Rotate the rotor
            @@pos_rotor3 += 1
            @@pos_rotor3 %= 26
        
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor3) % 26] + 26 - @@pos_rotor3) % 26 + 'a'.ord).chr
        
            # Get the resulting character from the second rotor recusively
            return rotor2(result, rotate: rotate_next)
        end
    end
    
    def rotor2(char, reverse: false, rotate: false)
        # Initialize the rotor
        encrypt_string = "ajdksiruxblhwtmcqgznpyfvoe"
        encrypt_num = encrypt_string.chars.map { |c| c.ord - 'a'.ord }
        notch = "e"
        rotor = Hash.new
        for i in 0..25 do
            rotor[i] = encrypt_num[i]
        end
        if reverse
            rotor = rotor.invert
    
            # Get the resulting character
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor2) % 26] + 26 - @@pos_rotor2) % 26 + 'a'.ord).chr
    
            # Get the resulting character from the first rotor recusively
            return rotor3(result, reverse: true)
        else
            rotate_next = false
            if rotate
                if @@pos_rotor2 == (notch.ord - 'a'.ord)
                    # Rotate the second rotor
                    rotate_next = true
                end
    
                # Rotate the rotor, if we have hit reversal
                @@pos_rotor2 += 1
                @@pos_rotor2 %= 26
            end
    
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor2) % 26] + 26 - @@pos_rotor2) % 26 + 'a'.ord).chr
    
            # Get the resulting character from the third rotor recusively
            return rotor1(result, rotate: rotate_next)
        end
    end
    
    def rotor1(char, reverse: false, rotate: false)
        # Initialize the rotor
        encrypt_string = "ekmflgdqvzntowyhxuspaibrcj"
        encrypt_num = encrypt_string.chars.map { |c| c.ord - 'a'.ord }
        notch = "q"
        rotor = Hash.new
        for i in 0..25 do
            rotor[i] = encrypt_num[i]
        end
        if reverse
            rotor = rotor.invert
    
            # Get the resulting character
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor1) % 26] + 26 - @@pos_rotor1) % 26 + 'a'.ord).chr
    
            # Get the resulting character from the second rotor recusively
            return rotor2(result, reverse: true)
        else
            if rotate
                @@pos_rotor1 += 1
                @@pos_rotor1 %= 26
            end
    
            result = ((rotor[(char.ord - 'a'.ord + @@pos_rotor1) % 26] + 26 - @@pos_rotor1) % 26 + 'a'.ord).chr
    
            # Get the resulting character from the reflector
            return reflector(result)
        end
    end
    
    def reflector(char)
        # Initialize the reflector
        encrypt_string = "yruhqsldpxngokmiebfzcwvjat"
        encrypt_num = encrypt_string.chars.map { |c| c.ord - 'a'.ord }
        reflector = Hash.new
        for i in 0..25 do
            reflector[i] = encrypt_num[i]
        end
        result = (reflector[char.ord - 'a'.ord] + 'a'.ord).chr
        return rotor1(result, reverse: true)
    end
end
