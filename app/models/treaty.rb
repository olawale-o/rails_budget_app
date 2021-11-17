class Treaty < ApplicationRecord
  belongs_to :user, foreign_key: :author_id, class_name: 'User'
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  has_and_belongs_to_many :groups
end