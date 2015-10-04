class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.string :type, null: false
      t.string :author, null: false
      t.integer :year, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.jsonb :extra_info

      t.timestamps null: false
    end
  end
end
