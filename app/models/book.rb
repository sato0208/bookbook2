# バリデーションなど行う画面
class Book < ApplicationRecord
	# 一つのuserモデルと多数のブックを関連つけする
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length:{ maximum: 200}
end