class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :genre
  attr_accessible :title, :author_id, :genre_id, :published_at

  delegate :full_name, :to => :author, :prefix => true
end
