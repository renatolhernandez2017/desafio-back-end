class EntityUser < ApplicationRecord
  belongs_to :entity
  belongs_to :user

  validates :user_id, uniqueness: { scope: :entity_id }
end
