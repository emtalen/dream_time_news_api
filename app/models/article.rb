class Article < ApplicationRecord
  validates_presence_of :title, :content, :author

  belongs_to: (User: [role: journalist])
end