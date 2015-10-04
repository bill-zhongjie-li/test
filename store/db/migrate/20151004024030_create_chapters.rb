class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :item

      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
