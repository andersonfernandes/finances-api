require 'rails_helper'

RSpec.describe V1::CreditCardsController, '#update', type: :request do
  let(:setup) {}
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:credit_card) { create(:credit_card, user: user) }

  let(:params) do
    {
      name: 'Credit Card A',
      billing_day: 5,
      limit: 5000.00
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    setup
    put v1_credit_card_path(credit_card), params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the credit card belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('name' => params[:name])
          .and include('limit' => params[:limit].to_s)
          .and include('billing_day' => params[:billing_day])
      end
    end

    context 'and the credit card does not exist' do
      let(:credit_card) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find CreditCard with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end

    context 'and the update action fails' do
      let(:setup) { allow_any_instance_of(CreditCard).to receive(:update).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
