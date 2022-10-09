require 'rails_helper'

RSpec.describe V1::AccountsController, '#index', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:account1) { create(:account, user: user1) }
  let!(:account2) { create(:account, user: user2) }
  let!(:account3) { create(:account, user: user1) }

  let(:headers) { authorization_header(user1) }

  before { get v1_accounts_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 categories and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 2 }
      it do
        expect(response_body.first)
          .to include('id' => account1.id)

        expect(response_body.second)
          .to include('id' => account3.id)
      end
    end
  end
end
