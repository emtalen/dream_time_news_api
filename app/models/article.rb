class Article < ApplicationRecord
  validates_presence_of :title, :content

  belongs_to :author, class_name: 'User'
  
  has_one_attached :image
end