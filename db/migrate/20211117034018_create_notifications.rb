class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true, type: :integer
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
