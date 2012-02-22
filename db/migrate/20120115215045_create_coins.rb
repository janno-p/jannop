class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :nominal_value, null: false, limit: 4
      t.integer :country_id, null: false
      t.integer :commemorative_year
      t.string :image_file_name, null: false
      t.string :image_content_type, null: false
      t.integer :image_file_size, null: false
      t.datetime :collected_at
      t.string :collected_by
      t.string :type, null: false
      t.timestamps
    end
  end
end
