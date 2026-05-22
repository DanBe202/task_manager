class Task < ApplicationRecord
  enum :priority, { low: 0, medium: 1, high: 2 }

  validates :title, presence: true
end
