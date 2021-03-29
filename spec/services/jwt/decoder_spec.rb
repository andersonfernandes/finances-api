require 'rails_helper'

describe Jwt::Decoder do
  describe '#call' do
    context 'with an valid access_token' do
      let(:user) { create(:user) }
      let(:access_token) do 
        JWT.encode(
          {
            user_id: user.id,
            exp: 2.days.from_now.to_i
          },
          Figaro.env.secret_key_base
        )
      end

      it do
        expected_result = {
          user_id: user.id,
          exp: 2.days.from_now.to_i
        }

        expect(subject.call(access_token)).to eq(expected_result)
      end
    end

    context 'with an invalid access_token' do
      it do
        expect { subject.call('invalid_token') }
          .to raise_error(Jwt::Errors::InvalidToken)
      end
    end

    context 'with an expired access_token' do
      let(:user) { create(:user) }
      let(:access_token) do 
        JWT.encode(
          {
            user_id: user.id,
            exp: 2.days.ago.to_i
          },
          Figaro.env.secret_key_base
        )
      end

      it do
        expect { subject.call(access_token)}.to raise_error(Jwt::Errors::ExpiredToken)
      end
    end
  end
end
