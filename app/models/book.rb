class Book < ActiveRecord::Base
  belongs_to :author
  attr_accessible :title, :author_id, :published_at
end
