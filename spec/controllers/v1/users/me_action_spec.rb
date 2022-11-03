require 'rails_helper'

RSpec.describe V1::UsersController, '#me', type: :request do
  let(:user) { create(:user) }
  let!(:default_account) { create(:account, default: true, user: user) }

  let(:headers) { authorization_header(user) }

  before { get v1_users_me_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    it 'returns the current user info' do
      expect(response_body).to match(
        'name' => user.name,
        'email' => user.email,
        'default_account' => {
          'id' => default_account.id,
          'description' => default_account.description,
          'name' => default_account.name,
        }
      )
    end
  end
end
