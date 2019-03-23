require 'rails_helper'

describe Users::Authenticate do
  subject(:context) { described_class.call(email, password) }

  let!(:user) { create(:user, email: 'john@mail.com', password: '1234') }

  describe '.call' do
    context 'when the context is successful' do
      let(:email) { user.email }
      let(:password) { user.password }

      it { expect(context).to be_success }
      it { expect(context.result).not_to be_empty }
    end

    context 'when the context is not successful' do
      let(:email) { 'wrong_email' }
      let(:password) { 'wrong_password' }

      it { expect(context).to be_failure }
      it { expect(context.errors).to include(:user_authentication) }
    end
  end
end
