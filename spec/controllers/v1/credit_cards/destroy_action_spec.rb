require 'rails_helper'

RSpec.describe V1::CreditCardsController, '#destroy', type: :request do
  let(:setup) {}
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:credit_card) { create(:credit_card, user: user) }

  let(:headers) { authorization_header(user) }

  before do
    setup
    delete v1_credit_card_path(credit_card), headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the credit card belongs to the current user' do
      it { expect(response).to have_http_status(:no_content) }
      it { expect(CreditCard.count).to eq 0 }
    end

    context 'and the credit card does not exist' do
      let(:credit_card) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find CreditCard with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end

    context 'and the destroy action fails' do
      let(:setup) { allow_any_instance_of(CreditCard).to receive(:destroy).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
