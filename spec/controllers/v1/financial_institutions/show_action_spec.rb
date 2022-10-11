require 'rails_helper'

RSpec.describe V1::FinancialInstitutionsController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:financial_institution) { create(:financial_institution) }

  let(:headers) { authorization_header(user) }

  before { get v1_financial_institution_path(financial_institution), headers: headers }

  include_context 'when the user is not authenticated'
end
