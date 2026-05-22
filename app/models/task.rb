class Task < ApplicationRecord
  enum :priority, { low: 0, medium: 1, high: 2 }

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: [ false, nil ]) }
  scope :high_priority, -> { where(priority: :high) }
  scope :due_this_week, -> {
    where(due_date: Date.current.beginning_of_week..Date.current.end_of_week)
  }
end
