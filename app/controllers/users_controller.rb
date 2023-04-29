class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :new_book, only: [:index, :show]
  
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @books = Book.where(user_id: params[:id])
  end

  def edit; end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def new_book
      @book = Book.new
    end
    
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
    end
end
