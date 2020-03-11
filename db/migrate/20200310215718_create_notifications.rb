class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :icon
      t.string :title
      t.string :url
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
