module Api
  module V1
    module Transaction
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.include Api::V1::Category::Response
          base_class.include Api::V1::Account::Response
          base_class.def_param_group :transaction_response do
            schema.except(:account_id, :category_id).each do |name, info|
              type, options = [info[:type], info.slice(:desc, :base_class)]

              property(name, type, options)
            end

            property(:category, Hash) { param_group :category_response }
            property(:account, Hash) { param_group :account_response }
          end
        end
      end
    end
  end
end
