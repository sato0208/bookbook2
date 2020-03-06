class UsersController < ApplicationController

# 3/6自分で追加した文
  def new
  	@user = User.new
  end
  # 新規に作成したらcreateアクションが開く

  def show
  	@user = User.find(params[:id])
  end

  def edit
# ユーザ情報を取得してインスタンス@userに保存し、編集用viewでform_forを使う準備
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
	  	if @user.update(user_params)
	  		redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
	  	else render :edit
	  	end
  	end

  private
  # 名前とプロフィールイメージがきちんと入っているかチェックする
  def user_params
  	params.require(:user).permit(:name, :profile_image)
  end
end
