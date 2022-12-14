class Photo < ActiveRecord::Base
  # Фотография оставлена к какому-то события
  belongs_to :event

  # Фотографию добавил какой-то пользователь
  belongs_to :user, optional: true

  # У фотографии всегда есть событие и пользователь
  validates :event, presence: true
  validates :user, presence: true
  validates :photo, attached: true, content_type: [:png, :jpg, :jpeg]

  # Добавляем аплоадер фотографий, чтобы заработал carrierwave
  has_one_attached :photo

  # Этот scope нужен нам, чтобы отделить реальные фотки от болваной
  # см. events_controller
  scope :persisted, -> { where "id IS NOT NULL" }


end
