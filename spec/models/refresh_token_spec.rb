require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#encrypted_token' do
      it { should validate_presence_of(:encrypted_token) }

      context 'uniqueness' do
        subject { build(:refresh_token) }

        it { should validate_uniqueness_of(:encrypted_token) }
      end
    end
  end
end
