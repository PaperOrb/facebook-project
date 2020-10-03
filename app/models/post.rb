class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  accepts_nested_attributes_for :comments
end
