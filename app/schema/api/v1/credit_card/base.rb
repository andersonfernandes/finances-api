module Api
  module V1
    module CreditCard
      module Base
        def self.schema # rubocop:disable Metrics/MethodLength
          {
            id: {
              type: :number,
              desc: 'Credit Card ID',
              required: { on_create: false, on_update: true }
            },
            name: {
              type: String,
              desc: 'Credit Card name',
              required: { on_create: true, on_update: false }
            },
            closing_day: {
              type: :number,
              desc: 'Credit Card closing day',
              required: { on_create: true, on_update: false }
            },
            due_day: {
              type: :number,
              desc: 'Credit Card due day',
              required: { on_create: true, on_update: false }
            },
            limit: {
              type: :decimal,
              desc: 'Credit Card transactions limit',
              required: { on_create: true, on_update: false }
            },
            financial_institution_id: {
              type: :decimal,
              desc: 'Credit Card financial institution id',
              required: { on_create: true, on_update: false }
            }
          }
        end
      end
    end
  end
end
