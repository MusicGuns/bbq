module ApplicationHelper
  # Возвращает путь к аватарке данного юзера. Если у пользователя есть его 
  # личная, возвращает её, иначе стандартную.
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(resize: "200x200")
    else
      asset_path('user.png')
    end
  end

  # Аналогично user_avatar, только возвращает миниатюрную версию
  def user_avatar_thumb(user)
    if user.avatar.attached?
      url_for(user.avatar.variant(resize: "100x100"))
    else
      asset_path('user.png')
    end
  end

  # Возвращает адерс рандомной фотки события, если есть хотя бы одна. Или ссылку
  # на дефолтную картинку.
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      url_for(photos.sample.photo)
    else
      asset_path('event.jpg')
    end
  end

  # Аналогично event_photo, только возвращает миниатюрную версию
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.variant(resize: [100, 100])
    else
      asset_path('event_thumb.jpg')
    end
  end

  # Хелпер для иконок font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def user_subscriber_or_author?(event)
    (event.subscribers + [event.user]).include?(current_user) || event.password.nil?
  end
end
