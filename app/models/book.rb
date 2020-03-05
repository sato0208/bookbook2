class Book < ApplicationRecord
	# 一つのuserモデルと多数のブックを関連つけする
	belongs_to :user

# 　	※新規投稿時のバリデーションがどうしてもできないので後で実装すること
	# validates :title, pressence: true
	# validates :body, pressence: true
end
