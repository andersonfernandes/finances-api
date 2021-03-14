module V1
  class FinancialInstitutionsController < ApplicationController
    before_action :set_financial_institution, only: :show

    resource_description do
      short 'Financial Institutions Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :financial_institution do
      property :id, :number, desc: 'Financial Institution id'
      property :name, String, desc: 'Financial Institution name'
      property :logo_url, String, desc: 'Financial Institution logo url'
    end

    api :GET, '/v1/financial_institutions', 'List all financial institutions'
    returns array_of: :financial_institution, code: 200, desc: 'Successful response'
    def index
      financial_institution = FinancialInstitution.all

      render json: financial_institution.map(&:to_response), status: :ok
    end

    api :GET, '/v1/financial_institutions/:id', 'Returns a financial institutions'
    param :id, :number, desc: 'Financial Institution id'
    returns code: 200, desc: 'Successful response' do
      param_group :financial_institution
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
