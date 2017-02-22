class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration, presence: true
  validates :duration, numericality: true
  validates :workout, presence: true
  validates :workout_date, presence:true
end
