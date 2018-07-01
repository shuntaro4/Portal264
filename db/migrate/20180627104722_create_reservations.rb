class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :concert, foreign_key: true
      t.string :name
      t.string :mail
      t.integer :ticket

      t.timestamps
    end
  end
end
