class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 30 }
  validates :start_time, presence: true
end
