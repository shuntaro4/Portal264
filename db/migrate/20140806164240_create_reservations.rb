class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
        t.references :concert
        t.string :name
        t.string :mail
        t.integer :ticket
        t.timestamps
    end
  end
end
