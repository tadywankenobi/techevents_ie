class AddFoursquareIdToVenue < ActiveRecord::Migration
  def change
  	add_column :venues, :fs_id, :string
  end
end
