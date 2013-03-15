class AddSourceIdToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :source_id, :string
  end
end
