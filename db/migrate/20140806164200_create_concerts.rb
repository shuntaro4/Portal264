class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :title
      t.datetime :open_at
      t.datetime :start_at
      t.string :place
      t.text :note

      t.timestamps
    end
  end
end
