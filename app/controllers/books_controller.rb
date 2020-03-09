# これはbooksコントローラー

class BooksController < ApplicationController

	def new
		@book = Book.new
	end

# 投稿データの保存
def create
# book_paramsで投稿データとして許可されているパラメーターかチェック
@book = Book.new(book_params)
# 今ログインしているユーザのIDをuser_idへ代入する。この項目を入力しないとviewへ送れない
@book.user_id = current_user.id
@books = Book.all
@user_profire = current_user
	if @book.save
		redirect_to books_path, notice: 'You have creatad book successfully.'
	else
		render :index
	end
end

def index
	@book = Book.new
	@books = Book.all
	@user_profire = current_user
  		# @user = current_user
  	end

# 投稿データの詳細画面表示
def show
	@book = Book.find(params[:id])
	@books = Book.all
	@user = Book.find(params[:id]).user
	@user_profire = current_user
end

# 投稿データの編集機能
def edit
	@book = Book.find(params[:id])
		# editの時layots/no_sidebarへ
		render layout: "no_sidebar"
	end

# 編集して登録する機能
def update
	@book = Book.find(params[:id])
	if @book.update(book_params)
		redirect_to books_path, notice:'You have updated book successfully.'
	else
		render :edit
	end
end

# 削除機能
def destroy
	@book = Book.find(params[:id])
	@book.destroy
	redirect_to books_path
end

# 投稿データのストロングパラメーター create、updateに渡す役割
private
def book_params
	params.require(:book).permit(:title, :body, :user_id)
end
end