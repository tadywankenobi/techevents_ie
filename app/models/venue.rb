class Venue < ActiveRecord::Base
	has_many :events

  def full_address
		"#{address}, #{county}"
  end
end
