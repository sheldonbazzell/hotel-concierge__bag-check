class AddSizeToLockers < ActiveRecord::Migration
  def change
  	add_column :lockers, :size, :integer, default: 0
  end
end
