class HomeController < ApplicationController
  def index
    if (params[:commit] != nil)
      @key = params[:key]
      @input_text = params[:input_text]
      @cipher_type = params[:cipher_type]

      @file_type = "txt"

      @result = HomeHelper.encryptDecrypt(params).force_encoding(Encoding::ASCII_8BIT)

      # Handle if decrypting file, removing added line at the end of the file
      @result_bytes = @result.bytes
    end
  end
end
