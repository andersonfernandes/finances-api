require 'rails_helper'

RSpec.describe Token, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#jwt_id' do
      subject { build(:token) }

      it { should validate_presence_of(:jwt_id) }
      it { should validate_uniqueness_of(:jwt_id) }
    end

    describe '#status' do
      it { should validate_presence_of(:status) }
      it { should define_enum_for(:status) }
    end

    describe '#expiry_at' do
      it { should validate_presence_of(:expiry_at) }
    end
  end

  describe '#access_token_payload' do
    subject { create(:token) }

    let(:expected_payload) do
      {
        user_id: subject.user_id,
        jti: subject.jwt_id,
        iat: subject.updated_at.to_i,
        exp: subject.expiry_at.to_i
      }
    end

    it { expect(subject.access_token_payload).to eq(expected_payload) }
  end
end
