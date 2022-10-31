require 'rails_helper'

RSpec.describe PhotoPolicy do

  let(:user_without_event) { FactoryGirl.create(:user) }

  let(:photo) { FactoryGirl.create(:photo) }

  subject { PhotoPolicy }

  context "when user not authenticated cant create Photo" do
    permissions :create? do
      it { is_expected.not_to permit(nil, Photo) }
    end
  end

  context "when user authenticated cant create Photo" do
    permissions :create? do
      it { is_expected.not_to permit(:user_without_event, photo) }
    end
  end

  context "when user is autorized and can delete your photo" do
    permissions :destroy? do
      it { is_expected.to permit(photo.user, photo) }
    end
  end

  context "when user is autorized and can delete any photo" do
    permissions :destroy? do
      it { is_expected.to permit(photo.event.user, photo) }
    end
  end
end
