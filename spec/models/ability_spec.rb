# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { described_class.new(user) }

  context 'when the user is admin' do
    let(:user) { create(:user, role: 'admin') }

    it { is_expected.to be_able_to(:manage, :all) }

    it { is_expected.to be_able_to(:manage, Appointment) }
    it { is_expected.to be_able_to(:manage, Store) }
    it { is_expected.to be_able_to(:manage, User) }
    it { is_expected.to be_able_to(:manage, Visitor) }
  end

  context 'when the user is employee' do
    let(:store) { create(:store) }
    let(:user) { create(:user, role: 'employee', store: store) }

    it { is_expected.to be_able_to(:manage, Appointment) }

    it { is_expected.not_to be_able_to(:create, Store) }
    it { is_expected.not_to be_able_to(:create, User) }
    it { is_expected.not_to be_able_to(:create, Visitor) }
    it { is_expected.not_to be_able_to(:read, Store) }
    it { is_expected.not_to be_able_to(:read, User) }
    it { is_expected.not_to be_able_to(:read, Visitor) }
    it { is_expected.not_to be_able_to(:update, Store) }
    it { is_expected.not_to be_able_to(:update, User) }
    it { is_expected.not_to be_able_to(:update, Visitor) }
    it { is_expected.not_to be_able_to(:destroy, Store) }
    it { is_expected.not_to be_able_to(:destroy, Visitor) }
  end
end
