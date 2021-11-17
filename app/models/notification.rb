class Notification < ApplicationRecord
  belongs_to :user
  has_many :relationship_notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :kind, presence: true

  enum kind: { first_signin: 0, followed: 1 }

  scope :latest_followed, -> { followed.last }

  def is_created_in?(time)
    created_at > Time.current.ago(time)
  end
end
