class Friendship < ApplicationRecord
  belongs_to :user # returns person that friended
  belongs_to :friend, class_name: "User" # returns friended person
end
