class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :direction
      t.string :hashed_value
    end
  end
end
