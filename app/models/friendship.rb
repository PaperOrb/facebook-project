class Friendship < ApplicationRecord
  belongs_to :user # returns friender
  belongs_to :friend, class_name: "User" # returns friendee
end
