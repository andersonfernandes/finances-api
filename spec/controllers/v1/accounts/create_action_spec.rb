require 'rails_helper'

RSpec.describe V1::AccountsController, '#create',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:financial_institution) { create(:financial_institution) }

  let(:params) do
    {
      description: Faker::Lorem.sentence(word_count: 3, supplemental: true),
      account_type: 'checking',
      name: Faker::Company.name,
      initial_amount: Faker::Commerce.price,
      financial_institution_id: financial_institution.id
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    setup
    post v1_accounts_path, params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'with missing params' do
      let(:params) { {} }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with valid params' do
      it { expect(response).to have_http_status(:created) }
      it do
        expect(response_body).to include('description' => params[:description])
          .and include('initial_amount' => params[:initial_amount].to_s)
          .and include('name' => params[:name])
          .and include('financial_institution' => {
                         'name' => financial_institution.name,
                         'logo_url' => financial_institution.logo_url
                       }).and include('account_type' => params[:account_type])
      end
    end
  end
end
