module Api
  module V1
    module Category
      module Request
        def self.included(base_class)
          request_factory = Api::Utils::RequestFactory.new(base_class, Base.schema)

          request_factory.build_create_request(:create_category_request, [:id])
          request_factory.build_update_request(:update_category_request)
        end
      end
    end
  end
end
