class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites,dependent: :destroy
	has_many :favorite_users,through: :favorites,source: :user
	has_many :book_comments,dependent: :destroy
	is_impressionable counter_cache: true
	scope :created_today, ->{ where(created_at: Time.zone.now.all_day) }
	scope :created_yesterday, ->{ where(created_at: 1.day.ago.all_day) }

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	def self.looks(searches, words)
    if searches == "perfect_match"
      @book = Book.where("title LIKE ?", "#{words}")
    else
      @post = Book.where("title LIKE ?", "%#{words}%")
    end
	end
end
