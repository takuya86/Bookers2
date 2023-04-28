class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @user = current_user
    @books = Book.where(user_id: params[:id])
    @book = Book.new
  end
  
  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to user_path(current_user.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  private

    def book_params
      params.require(:book).permit(:title, :body)
    end
  
end
