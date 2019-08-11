class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :url
      t.integer :visits_counter, default: 0
      t.string :encoded_id

      t.timestamps
    end
    add_index :short_urls, :encoded_id, unique: true
  end
end
