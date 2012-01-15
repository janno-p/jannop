class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.timestamps
    end
  end
end
