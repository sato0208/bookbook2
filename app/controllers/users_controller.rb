class UsersController < ApplicationController
# authenticate_user！でログイン認証されてない場合home画面へリダイレクトとする
  before_action :authenticate_user!
  # カレントユーザーだけしかedit,update,destroyアクションは使えない。
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  # ※カレントユーザー以外は直接リンクを入力しても編集ページにいけないようにする
def ensure_correct_user
  @user = User.find(params[:id])
  # ※カレントユーザーIDがbook.user_idと同じでない場合はbooks_pathへ飛ばす
  @user_profire = current_user
  if current_user.id != @user.id
    redirect_to user_path(@user_profire)
  end
end

def show
 @user = User.find(params[:id])
  # Userテーブルからユーザデータを取り出してそれに紐づく内容をbooksとして表示する
  @user_books = User.find(params[:id]).books
  @book = Book.new
  @user_profire = current_user
end

def edit
  # ユーザ情報を取得してインスタンス@userに保存し、編集用viewでform_forを使う準備
  @user = User.find(params[:id])
  @book = Book.new

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
  @user = current_user
end

def destroy
  reset_session
  redirect_to root_path,notice: 'Signed out successfully.'
end


private
  # 名前とプロフィールイメージがきちんと入っているかチェックする
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end


end