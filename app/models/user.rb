class User < ApplicationRecord
	attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 多数のbookと一つのuserを関連づけする
  has_many :book, dependent: :destroy
  # プロフィール画像投稿できるようにする記述
  attachment :profile_image
  # 名前カラムの入力数は2〜20文字の間でバリデート
  validates :name, length:{in: 2..20 }
end
