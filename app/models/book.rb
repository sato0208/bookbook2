class Book < ApplicationRecord
	# 一つのuserモデルと多数のブックを関連づけする
	belongs_to :user
end
