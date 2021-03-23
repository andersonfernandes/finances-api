require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#token' do
      it { should validate_presence_of(:token) }

      context 'uniqueness' do
        subject { build(:refresh_token) }

        it { should validate_uniqueness_of(:token) }
      end
    end

    describe '#status' do
      it { should validate_presence_of(:status) }
      it { should define_enum_for(:status) }
    end
  end
end
