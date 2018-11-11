class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :direction, null: false
      t.string :hashed_value, null: false
    end

    add_index :urls, :direction, unique: true
    add_index :urls, :hashed_value, unique: true
  end
end
