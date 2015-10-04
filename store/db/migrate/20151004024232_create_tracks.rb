class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :item

      t.integer :seconds, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
