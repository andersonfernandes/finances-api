require 'rails_helper'

RSpec.describe V1::CreditCardsController, '#create', type: :request do
  let(:setup) {}
  let(:user) { create(:user) }

  let(:financial_institution) { create(:financial_institution) }

  let(:params) do
    {
      name: 'Credit Card A',
      billing_day: 10,
      limit: 5000.00
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    setup
    post v1_credit_cards_path, params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'with missing params' do
      let(:params) { {} }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with valid params' do
      it do
        expect(response).to have_http_status(:created)
        expect(response_body).to include('name' => params[:name])
          .and include('billing_day' => params[:billing_day])
          .and include('limit' => params[:limit].to_s)
      end
    end

    context 'and the save action fails' do
      let(:setup) { allow_any_instance_of(CreditCard).to receive(:save).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
