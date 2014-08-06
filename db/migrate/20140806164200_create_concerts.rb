class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :name
      t.datetime :open_at
      t.datetime :start_at
      t.datetime :end_at
      t.string :place
      t.string :note

      t.timestamps
    end
  end
end
