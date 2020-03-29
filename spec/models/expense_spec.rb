require 'rails_helper'

RSpec.describe Expense, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
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

    describe '#payment_method' do
      it { should validate_presence_of(:payment_method) }
      it { should define_enum_for(:payment_method) }
    end

    describe '#spent_on' do
      it { should validate_presence_of(:spent_on) }
    end
  end

  context 'delegators' do
    it { should delegate_method(:id).to(:category).with_prefix }
    it { should delegate_method(:description).to(:category).with_prefix }
    it { should delegate_method(:to_response).to(:category).with_prefix }
  end

  describe 'to_response' do
    let(:expense) { create(:expense) }

    it do
      expect(expense.to_response).to include('id' => expense.id)
        .and include('description' => expense.description)
        .and include('amount' => expense.amount.to_s)
        .and include('spent_on' => expense.spent_on.to_time.iso8601)
        .and include('payment_method' => expense.payment_method)
        .and include('category' => expense.category.to_response)
    end
  end
end
