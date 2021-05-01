require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'relations' do
    it { should belong_to(:account) }
  end

  context 'validations' do
    describe '#closing_day' do
      it { should validate_presence_of(:closing_day) }
      it do
        should validate_numericality_of(:closing_day)
          .is_greater_than_or_equal_to(1)
          .is_less_than_or_equal_to(31)
      end
    end

    describe '#due_day' do
      it { should validate_presence_of(:due_day) }
      it do
        should validate_numericality_of(:due_day)
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
end
