require 'rails_helper'

RSpec.describe V1::AccountsController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }

  let(:headers) { authorization_header(user) }

  before { get v1_account_path(account), headers: headers }

  include_context 'when the user is not authenticated'
  context 'when the user is authenticated' do
    context 'and the account exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('description' => account.description)
          .and include('id' => account.id)
          .and include('name' => account.name)
      end
    end

    context 'and the category does not exist' do
      let(:account) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Account with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end
  end
end
