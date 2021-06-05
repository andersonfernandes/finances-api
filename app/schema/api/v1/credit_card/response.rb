module Api
  module V1
    module CreditCard
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.include Api::V1::Account::Response
          base_class.def_param_group :credit_card_response do
            schema.each do |name, info|
              type, desc = info.values_at(:type, :desc)
              property name, type, desc: desc
            end

            property(:account, Hash) { param_group :account_response, base_class }
          end
        end
      end
    end
  end
end
