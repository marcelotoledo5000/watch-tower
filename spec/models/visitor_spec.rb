require 'rails_helper'

describe Visitor, type: :model do
  subject(:visitor) { create(:visitor) }

  context 'with associations' do
    it { is_expected.to belong_to(:store).inverse_of(:visitors) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_length_of(:cpf).is_at_most(11) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end
end
