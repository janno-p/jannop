class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code, :null => false, :unique => true, :limit => 10
      t.string :name, :null => false, :unique => true, :limit => 32
      t.string :genitive, :null => false, :limit => 32
      t.timestamps
    end
  end
end
