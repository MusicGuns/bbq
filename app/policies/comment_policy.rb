class CommentPolicy < ApplicationPolicy
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

  private

  def current_user_can_edit?(user, comment)
    user.present? && (
      comment.user == user ||
      (comment.try(:event).present? && comment.event.user == user)
    )
  end
end
