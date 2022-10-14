# (с) goodprogrammer.ru
#
# Базовый класс для всех мэйлеров приложения
class ApplicationMailer < ActionMailer::Base
  # обратный адрес всех писем по умолчанию
  default from: ENV["MAIL_SENDER"]

  # Задаем макет для всех писем
  layout 'mailer'
end
