class AuthorSessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email],[:password])
      redirect_back_or_to(articles_path, notice: "Logged in")
    else
      flash.now.alert = "Login Failed"
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to(:authors, notice: "Logged!")
  end
end
