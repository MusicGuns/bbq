class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    password_authorization_successful?(record.cookies, record.event, record.password)
  end

  def update?
    user_is_owner?(record)
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def password_authorization_successful?(cookies, event, password)
    return true if event.user == user
    return true if event.password.nil?

    cookies.permanent["event_#{event.id}_password"] = password if password.present? && event.password == password

    return true if password_valid?(cookies, event)

    false
  end

  def password_valid?(cookies, event)
    cookies.permanent["event_#{event.id}_password"].present? &&
      cookies.permanent["event_#{event.id}_password"] == event.password
  end
end
