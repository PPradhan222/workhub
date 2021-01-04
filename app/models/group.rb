class Group < ApplicationRecord
  has_many :member_ships, dependent: :destroy
  has_many :users, through: :member_ships
  has_many :posts, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  def invited_user_ids
    invitations.pluck(:receiver_id) + member_ships.pluck(:user_id)
  end
end
