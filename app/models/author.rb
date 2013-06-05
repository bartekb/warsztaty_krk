class Author < ActiveRecord::Base
  attr_accessible :age, :first_name, :is_dead, :last_name

  paginates_per(10)

  def full_name
    "#{first_name} #{last_name}"
  end
end
