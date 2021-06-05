require 'rails_helper'

RSpec.describe V1::CreditCardsController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:credit_card) { create(:credit_card, account: create(:account, user: user)) }

  let(:headers) { authorization_header(user) }

  before { get v1_credit_card_path(credit_card), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the credit card exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('id' => credit_card.id)
          .and include('name' => credit_card.name)
      end
    end

    context 'and the category does not exist' do
      let(:credit_card) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find CreditCard with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end
  end
end
