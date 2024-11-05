# frozen_string_literal: true

require 'rails_helper'

describe Appointment do
  subject(:appointment) { create(:appointment) }

  context 'with associations' do
    it { is_expected.to belong_to(:visitor).inverse_of(:appointments) }
    it { is_expected.to belong_to(:store).inverse_of(:appointments) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:event_time) }
  end

  context 'with enum' do
    it do
      expect(appointment).to define_enum_for(:kind).
        with_values(check_in: 0, check_out: 1)
    end
  end
end
