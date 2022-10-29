class ApplicationController < ActionController::Base
  include Pundit

  class UserContext
    attr_reader :user, :password
  
    def initialize(user, password)
      @user = user
      @password = password
    end
  end
  
  def pundit_user
    UserContext.new(current_user, password_param)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :current_user_can_edit?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end
  
  # Вспомогательный метод, возвращает true, если текущий залогиненный юзер
  # может править указанную модель. Обновили метод — теперь на вход принимаем
  # event, или «дочерние» объекты
  def current_user_can_edit?(model)
    # Если у модели есть юзер и он залогиненный, пробуем у модели взять .event и
    # если он есть, проверяем его юзера на равенство current_user.
    user_signed_in? && (
      model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end
  
  private
  
  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
