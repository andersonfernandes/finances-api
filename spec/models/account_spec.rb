require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#account_type' do
      it { should validate_presence_of(:account_type) }
      it { should define_enum_for(:account_type) }
    end

    describe '#financial_institution' do
      it { should validate_presence_of(:financial_institution) }
    end

    describe '#initial_amount' do
      it { should validate_presence_of(:initial_amount) }
      it { should validate_numericality_of(:initial_amount) }
    end
  end

  describe '#to_response' do
    subject { create(:account) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'description' => subject.description,
        'name' => subject.name,
        'financial_institution' => subject.financial_institution,
        'initial_amount' => subject.initial_amount.to_s,
        'account_type' => subject.account_type
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
