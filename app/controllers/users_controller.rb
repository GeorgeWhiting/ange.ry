class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    encrypt(@user.password)
    @user.save
    redirect_to '/'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to '/'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def encrypt(password)
    salt = BCrypt::Engine.generate_salt
    encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end

end