module Api
  module V1
    module FinancialInstitution
      module Response
        def self.included(base)
          base.def_param_group :financial_institution_response do
            property :id, :number, desc: 'Financial Institution id'
            property :name, String, desc: 'Financial Institution name'
            property :logo_url, String, desc: 'Financial Institution logo url'
          end
        end
      end
    end
  end
end
