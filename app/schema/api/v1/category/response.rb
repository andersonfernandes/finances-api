module Api
  module V1
    module Category
      module Response
        def self.included(base_class)
          schema = Base.schema

          base_class.def_param_group :base_category do
            schema.each do |name, info|
              type, desc = info.values_at(:type, :desc)
              property name, type, desc: desc
            end
          end

          base_class.def_param_group :category_response do
            param_group :base_category

            property(:parent_category, Hash) { param_group :base_category, base_class }
            property(:child_categories, Array) { param_group :base_category, base_class }
          end
        end
      end
    end
  end
end
