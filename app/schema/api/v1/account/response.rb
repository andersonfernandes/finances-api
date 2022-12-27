module Api
  module V1
    module Account
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.def_param_group :account_response do
            schema.each do |name, info|
              property(name, info[:type], info.slice(:desc))
            end
          end
        end
      end
    end
  end
end
