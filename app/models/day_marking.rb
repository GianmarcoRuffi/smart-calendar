# app/models/day_marking.rb
class DayMarking < ApplicationRecord
  belongs_to :user
  validates :marked_on, presence: true
  validates :user_id, uniqueness: { scope: :marked_on }
end
