# バリデーションなど行う画面


class Book < ApplicationRecord
	# 一つのuserモデルと多数のブックを関連つけする
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true
end
