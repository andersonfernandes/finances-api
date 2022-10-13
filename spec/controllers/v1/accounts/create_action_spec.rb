require 'rails_helper'

RSpec.describe V1::AccountsController, '#create', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  let(:params) do
    {
      description: FFaker::Lorem.sentences.first,
      name: FFaker::Company.name
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
          .and include('name' => params[:name])
      end
    end

    context 'and the save action fails' do
      let(:setup) { allow_any_instance_of(Account).to receive(:save).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
