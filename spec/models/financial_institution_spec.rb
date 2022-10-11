require 'rails_helper'

RSpec.describe FinancialInstitution, type: :model do
  context 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end
  end
end
