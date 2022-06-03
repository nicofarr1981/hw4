class UsersController < ApplicationController
  def show
    @user = User.find_by({ "id" => params["id"] })
  end

  def new
    @user = User.new
  end

  def create
    @user_exists = User.find_by({ "email" => params["user"]["email"] })
    if @user_exists
      flash["notice"] = "You are already signed up"
      redirect_to "/login"
    else
      @user = User.new
      @user["username"] = params["user"]["username"]
      @user["email"] = params["user"]["email"]
      @user["password"] = BCrypt::Password.create(params["user"]["password"])
      @user.save
      redirect_to "/users/#{@user["id"]}"
    end
  end
end