require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user_without_event) { FactoryGirl.create(:user) }

  let(:event) { FactoryGirl.create(:event) }

  # объект тестирования (политика)
  subject { EventPolicy }

  context "when user is not autorized" do
    #let(:user_context_with_null) { EventContext.new(nil, nil) }

    permissions :create?, :new?, :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(nil, Event) }
    end
  end

  context "when user is autorized" do
    #let(:user_context) { UserContext.new(event.user, nil) }

    permissions :create?, :new?, :update?, :destroy?, :edit? do
      it { is_expected.to permit(event.user, event) }
    end
  end

  context "when user not have event" do
    #let(:user_context_without_event) { EventContext.new(user_without_event, nil) }

    permissions :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(user_without_event, event) }
    end
  end

  context "when user can view your event" do
    let(:event_context) { EventContext.new(event, nil) }

    permissions :show? do
      it { is_expected.to permit(event.user, event_context) }
    end
  end

  context "when subscriber can view event" do

    
    let(:subscription) { FactoryGirl.create(:subscription) }
    
    let(:subscriber_context) { EventContext.new(subscription.event, nil) }

    permissions :show? do
      it { is_expected.to permit(subscription.user, subscriber_context) }
    end
  end

  context "when password not true" do
    let(:event_context) { EventContext.new(event, "12") }

    permissions :show? do
      it { is_expected.not_to permit(user_without_event, event_context) }
    end
  end

  context "when password true" do
    let(:event_context) { EventContext.new(event, "123") }

    permissions :show? do
      it { is_expected.to permit(user_without_event, event_context) }
    end
  end
end