module Api
  module V1
    module Activity
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.include Api::V1::Category::Response
          base_class.def_param_group :activity_response do
            schema.except(:category_id).each do |name, info|
              property(name, info[:type], info.slice(:desc, :base_class))
            end

            property(:category, Hash) { param_group :category_response, base_class }
          end
        end
      end
    end
  end
end
