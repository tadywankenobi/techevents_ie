class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :title
      t.string :address
      t.string :county
      t.string :country
      t.float :lat
      t.float :lng

      t.timestamps
    end
    add_column :events, :venue_id, :integer
  end
end
