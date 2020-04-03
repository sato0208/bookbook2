class User < ApplicationRecord
	attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# foregin_key = 入口
# source = 出口

  # フォロー、フォロワー機能
  has_many :relationships
  # followingクラス（モデル）は今作った架空のものなので、補足を付け足す必要があります。
  # through: :relationships は「中間テーブルはrelationshipsだよ」って設定
  # source: :followは「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」って事
  # フォローしてる数
  has_many :followings, through: :relationships, source: :follow
  # has_many :reverse_of_relationshipsは
  # has_many :relaitonshipsの「逆方向」って意味

  # foreign_key: 'follow_id'は「relaitonshipsテーブルにアクセスする時、follow_idを入口として来てね！」
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # フォローされている数
  has_many :followers, through: :reverse_of_relationships, source: :user


  # 多数のbookと一つのuserを関連づけする
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # プロフィール画像投稿できるようにする記述
  attachment :profile_image
  # 名前カラムの入力数は2〜20文字の間でバリデート
  # validates :name, length:{in: 2..20 }, message: 'This site is only for under 2 and over 20'

  def follow(other_user)
    # フォローしようとしている other_user が自分自身ではないかを検証
    unless self == other_user
      # selfには実行したUserが代入される。見つかれば Relation を返し、
      # 見つからなければフォロー関係を保存(create = new + save)する
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

# フォローがあればアンフォローする
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    # relationship が存在すれば destroy します
    relationship.destroy if relationship
  end

# self.followings によりフォローしている User 達を取得し、
# include?(other_user) によって other_user が含まれていないかを確認
  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follows_by?(user)
    relationships.where(user_id: user.id).exists?
  end



  # 二文字以下はバリデート
  validates :name, presence: true, length:{ minimum: 2}
  # 二十文字以上はバリデート
  validates :name, presence: true, length:{ maximum: 20}
  # 五十文字以上はバリデート
  validates :introduction, length:{ maximum: 50}

end
