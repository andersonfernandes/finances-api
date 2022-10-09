require 'rails_helper'

RSpec.describe V1::FinancialInstitutionsController, '#index', type: :request do
  let(:user) { create(:user) }

  let!(:financial_institution1) { create(:financial_institution) }
  let!(:financial_institution2) { create(:financial_institution) }
  let!(:financial_institution3) { create(:financial_institution) }

  let(:headers) { authorization_header(user) }

  before { get v1_financial_institutions_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 financial institutions' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 3 }
      it do
        expect(response_body.first)
          .to include('name' => financial_institution1.name)
          .and include('logo_url' => financial_institution1.logo_url)

        expect(response_body.second)
          .to include('name' => financial_institution2.name)
          .and include('logo_url' => financial_institution2.logo_url)

        expect(response_body.third)
          .to include('name' => financial_institution3.name)
          .and include('logo_url' => financial_institution3.logo_url)
      end
    end
  end
end
