class ApplicationController < ActionController::Base
	# before_actionはすべてのコントローラ実行する際に最初に行われる
	# デバイスのコントローラー用
	before_action :configure_permitted_parameters, if: :devise_controller?
	# authenticate_user！でログイン認証されてない場合ログイン画面へリダイレクトとする
	before_action :authenticate_user!
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end

	# どこでも@current_user.idを使えるようにする
	# def set_current_user
	# 	@current_user = User.find_by(id: session[:user_id])
	# end
end
