require 'rails_helper'

RSpec.describe V1::AccountsController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  let(:headers) { authorization_header(user.id) }

  before { get v1_account_path(account), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the account exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('description' => account.description)
          .and include('id' => account.id)
          .and include('financial_institution' => account.financial_institution)
          .and include('initial_amount' => account.initial_amount.to_s)
          .and include('account_type' => account.account_type)
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
