module Api
  module V1
    module Category
      module Request
        def self.included(base_class)
          schema = Base.schema

          base_class.def_param_group :create_category_request do
            schema.except(:id).each do |name, info|
              type, desc, required = info.values_at(:type, :desc, :required)
              param name, type, desc: desc, required: required[:on_create], default_value: nil
            end
          end

          base_class.def_param_group :update_category_request do
            schema.each do |name, info|
              type, desc, required = info.values_at(:type, :desc, :required)
              param name, type, desc: desc, required: required[:on_update], default_value: nil
            end
          end
        end
      end
    end
  end
end
