module Api
  module V1
    module Transaction
      module Base
        def self.schema # rubocop:disable Metrics/MethodLength
          {
            id: {
              type: :number,
              desc: 'Transaction id',
              required: { on_create: false, on_update: true }
            },
            description: {
              type: String,
              desc: 'Transaction description',
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
              desc: 'Transaction date in ISO-8601 format',
              required: { on_create: true, on_update: false }
            },
            expires_at: {
              type: :iso8601_date,
              base_class: Date,
              desc: 'Transaction expiration date in ISO-8601 format',
              required: { on_create: false, on_update: false }
            },
            recurrent: {
              type: ['true', 'false'],
              desc: 'Indicates if the transaction is recurrent',
              required: { on_create: false, on_update: false }
            },
            category_id: {
              type: :number,
              desc: 'Transaction category ID',
              required: { on_create: true, on_update: false }
            },
            account_id: {
              type: :number,
              desc: 'Transaction account ID',
              required: { on_create: true, on_update: false }
            }
          }
        end
      end
    end
  end
end
