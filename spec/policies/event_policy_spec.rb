require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { User.new }


  let(:user_without_event) { User.new }

  let(:event) { Event.new(user: user)}

  # объект тестирования (политика)
  subject { EventPolicy }

  context "when user is not autorized" do
    permissions :create?, :new?, :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(nil, Event) }
    end
  end

  context "when user is autorized" do
    permissions :create?, :new?, :update?, :destroy?, :edit? do
      it { is_expected.to permit(user, event) }
    end
  end

  context "when user not have event" do
    permissions :update?, :destroy?, :edit? do
      it { is_expected.not_to permit(user_without_event, event) }
    end
  end
end