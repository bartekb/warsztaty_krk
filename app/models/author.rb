class Author < ActiveRecord::Base
  attr_accessible :age, :first_name, :is_dead, :last_name, :genre_ids

  paginates_per(10)

  has_and_belongs_to_many :genres

  def full_name
    "#{first_name} #{last_name}"
  end
end
