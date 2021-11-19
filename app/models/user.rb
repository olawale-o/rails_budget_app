class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :categories
  has_many :treaties

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true

  before_validation :remove_whitespace

  def my_categories_and_treaties
    categories.includes(:treaties)
  end

  private

  def remove_whitespace
    self.email = email.strip if email.nil?
    self.name = name.strip if name.nil?
  end
end
