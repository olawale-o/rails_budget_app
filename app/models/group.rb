class Group < ApplicationRecord
  belongs_to :user
  has_many_and_belongs_to :treaties
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :icon, presence: true, uniqueness: true
end
