# バリデーションなど行う画面


class Book < ApplicationRecord
	# 一つのuserモデルと多数のブックを関連つけする
	belongs_to :user

# 　	※新規投稿時のバリデーションがどうしてもできないので後ですること
	validates :title, presence: true
	validates :body, presence: true
end
