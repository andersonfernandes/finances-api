module Api
  module V1
    module Account
      module Response
        def self.included(base_class)
          base_class.include Api::V1::FinancialInstitution::Response

          base_class.def_param_group :account_response do
            property :id, :number, desc: 'Account id'
            property :name, String, desc: 'Account name'
            property :description, String, desc: 'Account description'
            property :financial_institution, Hash do
              param_group :financial_institution_response
            end
            property :initial_amount, :decimal, desc: 'Account initial amount'
            property :account_type, ::Account.account_types.keys
          end
        end
      end
    end
  end
end
