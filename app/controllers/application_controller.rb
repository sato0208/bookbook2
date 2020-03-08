class ApplicationController < ActionController::Base
	# before_actionはすべてのコントローラ実行する際に最初に行われる
	# デバイスのコントローラー用
	before_action :configure_permitted_parameters, if: :devise_controller?
	# authenticate_user！でログイン認証されてない場合ログイン画面へリダイレクトとする
	before_action :authenticate_user!


	# ログイン後にマイページに飛ぶ
	def after_sign_in_path_for(resource)
   		user_url(resource)
 	end



 	# サイドバーの新規投稿画面用
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
		if @book.save
		   redirect_to books_path, notice: 'You have creatad book successfully.'
		else
			render :index
		end
	end



	# 名前ログインのために必要な記述
	protected
	# ログイン時のパラメーターを設定する
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
	end
	# データ更新時のパラメーターを設定する
	def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])

    end

end
