require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#billing_day' do
      it { should validate_presence_of(:billing_day) }
      it do
        should validate_numericality_of(:billing_day)
          .only_integer
          .is_greater_than_or_equal_to(1)
          .is_less_than_or_equal_to(31)
      end
    end

    describe '#limit' do
      it { should validate_presence_of(:limit) }
      it { should validate_numericality_of(:limit) }
    end

    describe '#name' do
      it { should validate_presence_of(:name) }
    end
  end

  describe '#to_response' do
    subject { create(:credit_card) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'name' => subject.name,
        'limit' => subject.limit.to_s,
        'billing_day' => subject.billing_day
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
