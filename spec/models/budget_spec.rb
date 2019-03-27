require 'rails_helper'

RSpec.describe Budget, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:budget_items) }
  end

  context 'validations' do
    describe '#description' do
      it { should validate_presence_of(:description) }
    end
  end
end
