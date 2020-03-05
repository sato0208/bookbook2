class BooksController < ApplicationController
	def new
	  @book = Book.new
	end

# 投稿データの保存
	def create
# book_paramsで投稿データとして許可されているパラメーターかチェック
		@book = Book.new(book_params)
		@book.save
		redirect_to books_path
	end

	def index
	  @book = Book.new
	  @books = Book.all
	end

	def show
	end

# 投稿データのストロングパラメーター 
private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
