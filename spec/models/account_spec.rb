require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:financial_institution) }
  end

  context 'delegators' do
    it { should delegate_method(:id).to(:financial_institution).with_prefix }
    it { should delegate_method(:name).to(:financial_institution).with_prefix }
    it { should delegate_method(:logo_url).to(:financial_institution).with_prefix }
  end

  describe '#to_response' do
    subject { create(:account) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'description' => subject.description,
        'name' => subject.name,
        'financial_institution' => {
          'id' => subject.financial_institution_id,
          'name' => subject.financial_institution_name,
          'logo_url' => subject.financial_institution_logo_url
        }
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
