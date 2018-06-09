class CreateConcerts < ActiveRecord::Migration[5.2]
  def change
    create_table :concerts do |t|
      t.string :title
      t.datetime :open_at
      t.datetime :start_at
      t.string :place
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :note
      t.boolean :active

      t.timestamps
    end
  end
end
