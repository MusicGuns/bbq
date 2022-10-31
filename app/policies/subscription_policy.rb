class SubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    current_user_can_edit?(@user, @record)
  end


  class Scope < Scope
    def resolve
      scope
    end
  end

  def current_user_can_edit?(user, subscription)
    user.present? && (
      subscription.user == user ||
      (subscription.try(:event).present? && subscription.event.user == user)
    )
  end
end
