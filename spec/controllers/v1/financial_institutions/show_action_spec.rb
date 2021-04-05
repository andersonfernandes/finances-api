require 'rails_helper'

RSpec.describe V1::FinancialInstitutionsController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:financial_institution) { create(:financial_institution) }

  let(:headers) { authorization_header(user) }

  before { get v1_financial_institution_path(financial_institution), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the financial institution exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body)
          .to include('name' => financial_institution.name)
          .and include('logo_url' => financial_institution.logo_url)
      end
    end

    context 'and the financial institution does not exist' do
      let(:financial_institution) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find FinancialInstitution with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end
  end
end
