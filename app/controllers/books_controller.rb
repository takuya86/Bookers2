class BooksController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update]
  before_action :new_book, only: [:index, :show]

  def index
    @books = Book.all
  end

  def show; end
  
  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit; end
  
  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private

    def book_params
      params.require(:book).permit(:title, :body)
    end
    
    def set_user
      @user = current_user
    end
    
    def set_book
      @book = Book.find(params[:id])
    end
    
    def new_book
      @newbook = Book.new
    end
  
end
