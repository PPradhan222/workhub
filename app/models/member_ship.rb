class MemberShip < ApplicationRecord
  belongs_to :users
  belongs_to :groups
end