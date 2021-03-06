class UserController < ApplicationController

  def index

    if current_user
      redirect_to "/user/#{current_user.id}"
    else
      @quotes = Quote.all.reverse_order
      render "quotes/index"
    end

  end

  def profile
    @user = User.find_by_id(params[:id])
    @quotes = @user.quotes.reverse_order

    render "quotes/index"
  end

end