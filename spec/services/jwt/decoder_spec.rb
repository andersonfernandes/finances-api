require 'rails_helper'

describe Jwt::Decoder do
  describe '#call' do
    let(:user) { create(:user) }
    let(:access_token) do
      JWT.encode(
        {
          user_id: user.id,
          exp: token_expiry_at
        },
        Figaro.env.secret_key_base
      )
    end

    context 'with an valid access_token' do
      let(:token_expiry_at) { 2.days.from_now.to_i }

      it do
        expected_result = {
          user_id: user.id,
          exp: 2.days.from_now.to_i
        }

        expect(subject.call(access_token)).to eq(expected_result)
      end
    end

    context 'with an invalid access_token' do
      let(:access_token) { 'invalid_access_token' }

      it do
        expect { subject.call(access_token) }.to raise_error(Jwt::Errors::InvalidToken)
      end
    end

    context 'with an expired access_token' do
      let(:token_expiry_at) { 2.days.ago.to_i }

      it do
        expect { subject.call(access_token) }.to raise_error(Jwt::Errors::ExpiredToken)
      end
    end
  end
end
