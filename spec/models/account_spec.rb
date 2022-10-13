require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end
  end

  context 'relations' do
    it { should belong_to(:user) }
  end

  describe '#to_response' do
    subject { create(:account) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'description' => subject.description,
        'name' => subject.name
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
