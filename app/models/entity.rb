class Entity < ApplicationRecord
  has_many :entity_users
  has_many :users, through: :entity_users

  validates :name, presence: true
end
