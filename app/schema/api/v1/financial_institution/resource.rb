module Api
  module V1
    module FinancialInstitution
      module Resource
        def self.included(base)
          base.resource_description do
            short 'Financial Institutions Actions'
            error code: 401, desc: 'Unauthorized'
            error code: 400, desc: 'Bad Request'
            error code: 404, desc: 'Not Found'
            error code: 422, desc: 'Unprocessable Entity'
            formats ['json']
          end
        end
      end
    end
  end
end
