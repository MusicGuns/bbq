class PhotoPolicy < ApplicationPolicy
  def create?
    user.present? && (record.event.subscribers + [record.event.user]).include?(user)
  end

  def destroy?
    current_user_can_edit?(@user, @record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  def current_user_can_edit?(user, photo)
    user.present? && (
      photo.user == user ||
      (photo.try(:event).present? && photo.event.user == user)
    )
  end
end
