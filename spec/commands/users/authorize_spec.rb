require 'rails_helper'

describe Users::Authorize do
  subject(:context) { described_class.call(headers) }

  let!(:user) { create(:user, email: 'john@mail.com', password: '1234') }
  let!(:valid_token) { ::JsonWebToken.encode(user_id: user.id) }

  describe '.call' do
    context 'when the token is valid ' do
      let(:headers) { { 'Authorization' => valid_token } }

      it { expect(context).to be_success }
      it { expect(context.result).to eq user }
    end

    context 'when the token is invalid' do
      let(:headers) { { 'Authorization' => 'invalid_token' } }

      it { expect(context).to be_failure }
      it { expect(context.errors).to include(:token) }
    end

    context 'when the context is not present' do
      let(:headers) { {} }

      it { expect(context).to be_failure }
      it { expect(context.errors).to include(:token) }
    end
  end
end
