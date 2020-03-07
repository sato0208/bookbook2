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
  # validates :name, length:{in: 2..20 }, message: 'This site is only for under 2 and over 20'

  # 二文字以下はバリデート
  validates :name, presence: true, length:{ minimum: 2}
  # 二十文字以上はバリデート
  validates :name, presence: true, length:{ maximum: 20}
  # 五十文字以上はバリデート
  validates :introduction, length:{ maximum: 50}

end
