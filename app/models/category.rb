class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :treaties
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :icon, presence: true, uniqueness: true

  before_validation :remove_whitespace

  def treaties_with_user
    treaties.includes(:user)
  end

  def total_amount
    treaties.sum(:amount)
  end

  private

  def remove_whitespace
    self.name = name.strip unless name.nil?
    self.icon = icon.strip unless icon.nil?
  end
end
