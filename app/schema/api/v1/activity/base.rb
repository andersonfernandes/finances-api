module Api
  module V1
    module Activity
      module Base
        def self.schema # rubocop:disable Metrics/MethodLength
          {
            id: {
              type: :number,
              desc: 'Activity id',
              required: { on_create: false, on_update: true }
            },
            description: {
              type: String,
              desc: 'Activity description',
              required: { on_create: true, on_update: false }
            },
            amount: {
              type: :decimal,
              desc: 'Amount spent',
              required: { on_create: true, on_update: false }
            },
            paid_at: {
              type: :iso8601_date,
              base_class: Date,
              desc: 'Activity date in ISO-8601 format',
              required: { on_create: true, on_update: false }
            },
            expires_at: {
              type: :iso8601_date,
              base_class: Date,
              desc: 'Activity expiration date in ISO-8601 format',
              required: { on_create: false, on_update: false }
            },
            recurrent: {
              type: %w[true false],
              desc: 'Indicates if the activity is recurrent',
              required: { on_create: false, on_update: false }
            },
            category_id: {
              type: :number,
              desc: 'Activity category ID',
              required: { on_create: true, on_update: false }
            }
          }
        end
      end
    end
  end
end
