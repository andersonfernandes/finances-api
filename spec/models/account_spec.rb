require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:financial_institution) }
  end

  context 'validations' do
    describe '#account_type' do
      it { should validate_presence_of(:account_type) }
      it { should define_enum_for(:account_type) }
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
        'initial_amount' => subject.initial_amount.to_s,
        'account_type' => subject.account_type,
        'financial_institution' => {
          'name' => subject.financial_institution_name,
          'logo_url' => subject.financial_institution_logo_url
        }
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
