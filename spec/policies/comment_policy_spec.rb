require 'rails_helper'

RSpec.describe CommentPolicy do

  let(:user_without_event) { FactoryGirl.create(:user) }

  let(:comment) { FactoryGirl.create(:comment) }


  # объект тестирования (политика)
  subject { CommentPolicy }

  context "when user not authenticated can create comment" do
    permissions :create? do
      it { is_expected.to permit(nil, Comment) }
    end
  end

  context "when user is autorized and can delete your comment" do
    permissions :destroy? do
      it { is_expected.to permit(comment.user, comment) }
    end
  end

  context "when user is autorized and can delete any comment" do
    permissions :destroy? do
      it { is_expected.to permit(comment.event.user, comment) }
    end
  end
end
