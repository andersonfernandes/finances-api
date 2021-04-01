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
    let(:valid_token_expected_decode) do
      {
        user_id: user.id,
        exp: token_expiry_at
      }

    end

    context 'with an valid access_token' do
      let(:token_expiry_at) { 2.days.from_now.to_i }

      it { expect(subject.call(access_token)).to eq(valid_token_expected_decode) }
    end

    context 'with an invalid access_token' do
      let(:access_token) { 'invalid_access_token' }

      it { expect { subject.call(access_token) }.to raise_error(Jwt::Errors::InvalidToken) }
    end

    context 'with an expired access_token' do
      let(:token_expiry_at) { 2.days.ago.to_i }

      context 'and expiration verification set to true' do
        it { expect { subject.call(access_token) }.to raise_error(Jwt::Errors::ExpiredToken) }
      end

      context 'and expiration verification set to false' do
        it do
          expect(subject.call(access_token, verify_expiration: false))
            .to eq(valid_token_expected_decode)
        end
      end
    end
  end
end
