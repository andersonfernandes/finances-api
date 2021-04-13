module Api
  module V1
    module Transaction
      module Request
        def self.included(base_class)
          schema = Base.schema

          base_class.def_param_group :create_transaction_request do
            schema.except(:id).each do |name, info|
              type, required = info.values_at(:type, :required)
              options = info.slice(:desc, :base_class)

              param name, type, options.merge(required: required[:on_create], default_value: nil)
            end
          end

          base_class.def_param_group :update_transaction_request do
            schema.except(:account_id).each do |name, info|
              type, required = info.values_at(:type, :required)
              options = info.slice(:desc, :base_class)

              param name, type, options.merge(required: required[:on_update], default_value: nil)
            end
          end
        end
      end
    end
  end
end
