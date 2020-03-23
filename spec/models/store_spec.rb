# frozen_string_literal: true

require 'rails_helper'

describe Store, type: :model do
  context 'with validations' do
    subject(:store) { create(:store) }

    it { is_expected.to validate_presence_of(:cnpj) }
    it { is_expected.to validate_length_of(:cnpj).is_at_most(14) }
    it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end
end
