require 'rails_helper'

RSpec.describe V1::AccountsController, '#update', type: :request do
  let(:setup) {}
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }

  let(:params) do
    {
      description: FFaker::Lorem.sentences.first,
      name: FFaker::Company.name
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    setup
    put v1_account_path(account), params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the account belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
    end

    context 'and the account does not exist' do
      let(:account) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Account with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end

    context 'and the update action fails' do
      let(:setup) { allow_any_instance_of(Account).to receive(:update).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
