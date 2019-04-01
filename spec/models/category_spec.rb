require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'relations' do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:expenses) }
    it { should have_many(:budget_items) }
  end

  context 'validations' do
    describe '#description' do
      it { should validate_presence_of(:description) }
    end
  end

  describe '#to_response' do
    let(:category) { create(:category) }

    it do
      expect(category.to_response).to include('id' => category.id)
        .and include('description' => category.description)
    end
  end
end
