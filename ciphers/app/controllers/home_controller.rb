class HomeController < ApplicationController
  def index
    @key = params[:key]
    @input_text = params[:input_text]

    @result = HomeHelper.encryptDecrypt(params)


    render "index"
  end

end
