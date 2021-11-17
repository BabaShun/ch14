class CreateRelationshipNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :relationship_notifications do |t|
      t.references :notification, null: false, foreign_key: true, type: :integer
      t.references :relationship, null: false, foreign_key: true, type: :integer

      t.timestamps
    end

    add_index :relationship_notifications, [:relationship_id, :notification_id], unique: true, name: 'index_rn_on_ri_and_ni'
  end
end
