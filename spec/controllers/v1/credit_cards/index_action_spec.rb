require 'rails_helper'

RSpec.describe V1::CreditCardsController, '#index', type: :request do
  let(:user) { create(:user) }

  let!(:credit_card1) { create(:credit_card, user: user) }
  let!(:credit_card2) { create(:credit_card, user: user) }
  let!(:credit_card3) { create(:credit_card, user: user) }

  let(:headers) { authorization_header(user) }

  before { get v1_credit_cards_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 credit cards associated with the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 3 }
      it do
        expect(response_body.first)
          .to include('id' => credit_card1.id)

        expect(response_body.second)
          .to include('id' => credit_card2.id)

        expect(response_body.third)
          .to include('id' => credit_card3.id)
      end
    end
  end
end
