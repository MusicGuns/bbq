# (с) goodprogrammer.ru
#
# Модель Пользователя
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[yandex]

  # Юзер может создавать много событий
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :events

  validates :name, presence: true, length: { maximum: 35 }

  validates :email, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :avatar, content_type: %i[png jpg jpeg]

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  # Добавляем аплоадер аватарок, чтобы заработал carrierwave
  has_one_attached :avatar

  def self.find_for_oauth(access_token)
    email = access_token.info.email.downcase
    user = where(email: email).first
    nickname = access_token.info.nickname

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://#{provider}.ru/#{id}"

    where(url: url, provider: provider).first_or_create! do |new_user|
      new_user.email = email
      new_user.password = Devise.friendly_token.first(16)
      new_user.name = nickname
    end
  end

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
