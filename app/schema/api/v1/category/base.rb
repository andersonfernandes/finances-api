module Api
  module V1
    module Category
      module Base
        def self.schema # rubocop:disable Metrics/MethodLength
          {
            id: {
              type: :number,
              desc: 'Category ID',
              required: { on_create: false, on_update: true }
            },
            description: {
              type: String,
              desc: 'Category description',
              required: { on_create: true, on_update: true }
            },
            parent_category_id: {
              type: :number,
              desc: 'Parent category ID',
              required: { on_create: false, on_update: false }
            }
          }
        end
      end
    end
  end
end
