class HomeController < ApplicationController
  def index
    if (params[:commit] != nil)
      @key = params[:key]
      @input_text = params[:input_text]
      @cipher_type = params[:cipher_type]

      @result = HomeHelper.encryptDecrypt(params)
    end
  end
end
