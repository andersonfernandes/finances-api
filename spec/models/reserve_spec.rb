require 'rails_helper'

RSpec.describe Reserve, type: :model do
  context 'relations' do
    it { should belong_to(:account) }
    it { should have_many(:activities).through(:reserve_activities) }
  end

  context 'validations' do
    describe '#description' do
      it { should validate_presence_of(:description) }
    end

    describe '#initial_amount' do
      it { should validate_presence_of(:initial_amount) }
      it { should validate_numericality_of(:initial_amount) }
    end

    describe '#current_amount' do
      it { should validate_numericality_of(:current_amount) }
    end
  end
end
