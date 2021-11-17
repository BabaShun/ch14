class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :relationship_notifications, dependent: :destroy
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :create_notification

  private
  def create_notification
    latest_followed_notification = followed.notifications.latest_followed
    if latest_followed_notification.present? && latest_followed_notification.is_created_in?(5.minutes)
      notification = latest_followed_notification
    else
      notification = Notification.create!(
        user_id: followed.id,
        kind: 'followed',
      )
    end
    RelationshipNotification.create!(
      notification_id: notification.id,
      relationship_id: id
    )
  end
end
