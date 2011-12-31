class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :identifier_url, :null => false, :unique => true
      t.string :email, :null => false
      t.string :first_name
      t.string :last_name
      t.boolean :active, :null => false, :default => false
      t.timestamps
    end
  end
end
