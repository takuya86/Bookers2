class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "User was successfully updated."
    redirect_to user_path(@user.id)
  end


  private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
    
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to users_path
      end
    end
end
