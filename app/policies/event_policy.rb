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
    password_is_right?(record.event, record.password)
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

  def password_is_right?(event, password)
    if (event.subscribers + [event.user]).include?(user) || event.password.nil?
      true
    else
      event.password == password
    end
  end
end
