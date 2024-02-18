module Utils
    module Utils
        module_function
        def sanitize_input(input_text)
            return input_text.gsub(/[^a-zA-Z]/, '').downcase
        end
    end
end