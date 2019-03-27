require 'rails_helper'

RSpec.describe BudgetItem, type: :model do
  context 'relations' do
    it { should belong_to(:budget) }
    it { should belong_to(:category) }
  end

  context 'validations' do
    describe '#amount' do
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount) }
    end

    describe '#min_amount' do
      it { should validate_presence_of(:min_amount) }
      it { should validate_numericality_of(:min_amount) }
    end

    describe '#description' do
      it { should validate_presence_of(:description) }
    end
  end
end
