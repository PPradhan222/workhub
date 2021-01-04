class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :rememberable, :recoverable

  ROLES = {
    admin: 'admin'
  }

  has_one_attached :avatar
  has_many :member_ships, dependent: :destroy
  has_many :groups, through: :member_ships
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_one :invitation, dependent: :destroy
  has_many :messages
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'receiver_id', dependent: :destroy
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id', dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks

  validates :name, :date_of_birth, :mobile_number, :gender, presence: true
  validates :mobile_number, uniqueness: true
  #validate :age_must_be_greater_than_13

  scope :invitable, ->(invited_user_ids) { where.not(id: invited_user_ids)}

  def age_must_be_greater_than_13
    if Date.today.year - date_of_birth.year < 13
      errors.add(:date_of_birth, "age must be greater than or equal to 13")
    end
  end
end
