# frozen_string_literal: true

require 'rails_helper'

describe Store, type: :model do
  subject(:store) { create(:store) }

  context 'with associations' do
    it do
      expect(store).to have_many(:visitors).inverse_of(:store).
        dependent(:destroy)
    end

    it do
      expect(store).to have_many(:appointments).inverse_of(:store).
        dependent(:destroy)
    end

    it do
      expect(store).to have_many(:users).inverse_of(:store).
        dependent(:destroy)
    end
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:cnpj) }
    it { is_expected.to validate_length_of(:cnpj).is_at_most(14) }
    it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end
end
