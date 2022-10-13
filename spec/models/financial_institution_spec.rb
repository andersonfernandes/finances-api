require 'rails_helper'

RSpec.describe FinancialInstitution, type: :model do
  context 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end
  end

  describe '#to_response' do
    subject { create(:financial_institution) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'name' => subject.name,
        'logo_url' => subject.logo_url
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
