class BooksController < ApplicationController
  before_action :set_user, only: [:index, :create]
  before_action :set_book, only: [:show, :edit, :update]
  before_action :new_book, only: [:index, :show, :create]

  def index
    @books = Book.all
  end

  def show
    @user = @book.user
  end
  
  def create
    @newbook = current_user.books.new(book_params)
    if @newbook.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    redirect_to books_path unless @book.user == current_user
  end
  
  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
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
