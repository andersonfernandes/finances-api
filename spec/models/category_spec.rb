require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'relations' do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:expenses) }
  end

  context 'validations' do
    describe '#description' do
      it { should validate_presence_of(:description) }
    end
  end
end
