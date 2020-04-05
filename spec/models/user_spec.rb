# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  subject(:user) { create(:user) }

  context 'with associations' do
    it { is_expected.to belong_to(:store).optional }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:login) }
    it { is_expected.to validate_uniqueness_of(:login) }
    it { is_expected.to validate_length_of(:login).is_at_least(8) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    context 'when user is an employee' do
      subject(:user) { create(:user, role: 'employee', store: store) }

      let(:store) { create(:store) }

      it { is_expected.to validate_presence_of(:store_id) }
    end
  end

  context 'with enum' do
    it do
      expect(user).to define_enum_for(:role).
        with_values(employee: 0, admin: 1)
    end
  end
end
