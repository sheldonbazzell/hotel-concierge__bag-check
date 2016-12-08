class CreateLockers < ActiveRecord::Migration
  def change
    create_table :lockers do |t|
      t.boolean :available

      t.timestamps
    end
  end
end
