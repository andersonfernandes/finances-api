module V1
  class FinancialInstitutionsController < ApplicationController
    include Api::V1::FinancialInstitution::Resource
    include Api::V1::FinancialInstitution::Response

    before_action :set_financial_institution, only: :show

    api :GET, '/v1/financial_institutions', 'List all financial institutions'
    header 'Authentication', 'User access token', required: true
    returns array_of: :financial_institution_response, code: 200, desc: 'Successful response'
    def index
      financial_institution = FinancialInstitution.all

      render json: financial_institution.map(&:to_response), status: :ok
    end

    api :GET, '/v1/financial_institutions/:id', 'Returns a financial institutions'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Financial Institution id'
    returns code: 200, desc: 'Successful response' do
      param_group :financial_institution_response
    end
    def show
      render json: @financial_institution.to_response, status: :ok
    end

    private

    def set_financial_institution
      @financial_institution = FinancialInstitution.find(params[:id])
    end
  end
end
