class AddActiveToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :active, :boolean, default:true, null:false
  end
end
