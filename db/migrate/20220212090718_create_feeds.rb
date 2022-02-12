class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end
