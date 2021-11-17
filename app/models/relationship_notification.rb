class RelationshipNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :relationship

  validates :notification_id, presence: true
  validates :relationship_id, presence: true, uniqueness: { scope: :notification_id }
end
