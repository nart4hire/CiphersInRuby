class HomeController < ApplicationController
  def index
    if (params[:commit] != nil)
      @key = params[:key]
      @input_text = params[:input_text]
      @cipher_type = params[:cipher_type]
      # Default to text file
      @file_type = "txt"
      @content_type = "text/plain"
      
      @result = HomeHelper.encryptDecrypt(params)
      
      # Handle if decrypting file, extract file format and content type from first two lines
      if (@cipher_type == "super" or @cipher_type == "extended-vigenere") and params[:input_type] == "file"
        if params[:commit] == "Decrypt" 
          @content_type = @result.split("\n")[0]
          @file_type = @result.split("\n")[1]
          @result = @result.split("\n")[2..].join("\n")
        else
          @content_type = params[:input_file].headers.split("\n")[1].split(":")[1].strip
          @file_type = params[:input_file].original_filename.split('.').last
        end
      end


      @result_bytes = @result.bytes
    end
  end
end
