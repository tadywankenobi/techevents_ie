class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starting_at
      t.datetime :ending_at
      t.float :price
      t.string :information_url
      t.string :booking_url
      t.text :information

      t.timestamps
    end
  end
end
