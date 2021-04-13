module Api
  module V1
    module Account
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.include Api::V1::FinancialInstitution::Response
          base_class.def_param_group :account_response do
            schema.except(:financial_institution_id).each do |name, info|
              property(name, info[:type], info.slice(:desc))
            end

            property :financial_institution, Hash do
              param_group :financial_institution_response, base_class
            end
          end
        end
      end
    end
  end
end
