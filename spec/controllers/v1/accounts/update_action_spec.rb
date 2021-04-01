require 'rails_helper'

RSpec.describe V1::AccountsController, '#update',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:new_financial_institution) { create(:financial_institution) }

  let(:params) do
    {
      description: Faker::Lorem.sentence(word_count: 3, supplemental: true),
      account_type: 'checking',
      financial_institution_id: new_financial_institution.id,
      name: Faker::Company.name,
      initial_amount: Faker::Commerce.price
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    put(v1_account_path(account), params: params, headers: headers)
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the account belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('description' => params[:description])
          .and include('initial_amount' => params[:initial_amount].to_s)
          .and include('financial_institution' => {
                         'name' => new_financial_institution.name,
                         'logo_url' => new_financial_institution.logo_url
                       }).and include('account_type' => params[:account_type])
      end
    end

    context 'and the account does not exist' do
      let(:account) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Account with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end
  end
end
