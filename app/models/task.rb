class Task < ApplicationRecord
  validates :Status, presence: true, length: { maximum: 10 }
end
