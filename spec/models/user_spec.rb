require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end

    describe '#email' do
      it { should validate_presence_of(:email) }
    end
  end
end
