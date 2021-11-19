class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :treaties
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :icon, presence: true, uniqueness: true
end
