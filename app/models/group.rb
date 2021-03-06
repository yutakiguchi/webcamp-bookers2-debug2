class Group < ApplicationRecord
  has_many :groups_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true
end
