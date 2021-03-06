class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  validates :name, presence: true, uniqueness: true
end
