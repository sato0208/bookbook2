class UsersController < ApplicationController

# 3/6自分で追加した文
  def new
  	@user = User.new
  end
  # 新規に作成したらcreateアクションが開く

# userデータの保存
  def create
# user_paramsで投稿データとして許可されているパラメーターかチェック
    @user = User.new(user_params)
# 今ログインしているユーザのIDをuser_idへ代入する。この項目を入力しないとviewへ送れない
    @user.user_id = current_user.id
    @users = User.all
    if @user.save
       redirect_to users_path, notice: 'Welcome! You have signed up successfully.'
    else
      render :index
    end
  end

  def show
  	@user = User.find(params[:id])
# Userテーブルからユーザデータを取り出してそれに紐づく内容をbooksとして表示する
    @user_books = User.find(params[:id]).books
    @book = Book.new
  end

  def edit
# ユーザ情報を取得してインスタンス@userに保存し、編集用viewでform_forを使う準備
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
	  	if @user.update(user_params)
	  		redirect_to user_path(@user.id), notice: 'Signed in successfully.'
	  	else render :edit
	  	end
  	end

  def index
    @users = User.all
    @book = Book.new
  end

  private
  # 名前とプロフィールイメージがきちんと入っているかチェックする
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end