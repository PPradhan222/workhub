class Task < ApplicationRecord
  belongs_to :group
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks

  enum status: {
    assigned: 0,
    in_progress: 1,
    backlog: 2,
    done: 3
  }
end
