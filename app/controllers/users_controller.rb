class UsersController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You have successfully registered!"
    else
      flash[:danger] = @user.errors.full_messages
    end
  
    redirect_to root_path
  end

  def edit
    @user = User.friendly.find(params[:id])
    authorize @user
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize @user

    if @user.update(user_params)
      flash[:success] = "You've updated your details"
    else
      flash[:danger] = @user.errors.full_messages
    end
      redirect_to edit_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :image)
  end

end
