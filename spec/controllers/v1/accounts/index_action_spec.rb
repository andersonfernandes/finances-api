require 'rails_helper'

RSpec.describe V1::AccountsController, '#index',
               type: :request do
  let(:user_01) { create(:user) }
  let(:user_02) { create(:user) }
  let!(:account_01) { create(:account, user: user_01) }
  let!(:account_02) { create(:account, user: user_02) }
  let!(:account_03) { create(:account, user: user_01) }

  let(:headers) { authorization_header(user_01.id) }

  before { get v1_accounts_path, headers: headers }

  context 'when the user is authenticated' do
    context 'when have 3 categories and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 2 }
      it do
        expect(response_body.first)
          .to include('id' => account_01.id)

        expect(response_body.second)
          .to include('id' => account_03.id)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response_body).to include('message' => 'Unauthorized') }
  end
end
