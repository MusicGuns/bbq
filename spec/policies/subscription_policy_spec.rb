require 'rails_helper'

RSpec.describe SubscriptionPolicy do

  let(:user_without_event) { FactoryGirl.create(:user) }

  let(:subscription) { FactoryGirl.create(:subscription) }


  # объект тестирования (политика)
  subject { SubscriptionPolicy }

  context "when user not authenticated can create subscription" do
    permissions :create? do
      it { is_expected.to permit(nil, Subscription) }
    end
  end

  context "when user is autorized and can delete your subscription" do
    permissions :destroy? do
      it { is_expected.to permit(subscription.user, subscription) }
    end
  end

  context "when user is autorized and can delete any subscription" do
    permissions :destroy? do
      it { is_expected.to permit(subscription.event.user, subscription) }
    end
  end
end
