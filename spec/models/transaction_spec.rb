require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'relations' do
    it { should belong_to(:account) }
    it { should belong_to(:category) }
  end

  context 'validations' do
    describe '#amount' do
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount) }
    end

    describe '#description' do
      it { should validate_presence_of(:description) }
    end

    describe '#transaction_type' do
      it { should validate_presence_of(:transaction_type) }
      it { should define_enum_for(:transaction_type) }
    end

    describe '#spent_at' do
      it { should validate_presence_of(:spent_at) }
    end
  end

  context 'delegators' do
    it { should delegate_method(:id).to(:category).with_prefix }
    it { should delegate_method(:description).to(:category).with_prefix }
    it { should delegate_method(:to_response).to(:category).with_prefix }

    it { should delegate_method(:id).to(:account).with_prefix }
    it { should delegate_method(:to_response).to(:account).with_prefix }
  end

  describe 'to_response' do
    let(:transaction) { create(:transaction) }

    it do
      expect(transaction.to_response).to include('id' => transaction.id)
        .and include('description' => transaction.description)
        .and include('amount' => transaction.amount.to_s)
        .and include('spent_at' => transaction.spent_at.to_time.iso8601)
        .and include('transaction_type' => transaction.transaction_type)
        .and include('category' => transaction.category.to_response)
        .and include('account' => transaction.account.to_response)
    end
  end
end
