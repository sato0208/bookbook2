class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def edit
# ユーザ情報を取得してインスタンス@userに保存し、編集用viewでform_forを使う準備
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end

  private
  # 名前とプロフィールイメージがきちんと入っているかチェックする
  def user_params
  	params.require(:user).permit(:name, :profile_image)
  end
end
