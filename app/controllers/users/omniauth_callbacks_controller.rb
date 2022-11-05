class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def yandex
    @user = User.find_for_yandex_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Yandex')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Yandex',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end
