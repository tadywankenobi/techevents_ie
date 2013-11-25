class AddIndexToVenueId < ActiveRecord::Migration
  def change
  	add_index :events, :venue_id
  end
end
