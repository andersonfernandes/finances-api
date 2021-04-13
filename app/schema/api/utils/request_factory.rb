module Api
  module Utils
    class RequestFactory
      def initialize(context, schema)
        @context = context
        @schema = schema
      end

      def build_create_request(name, except_fields = [])
        build_request(:on_create, name, except_fields)
      end

      def build_update_request(name, except_fields = [])
        build_request(:on_update, name, except_fields)
      end

      private

      def build_request(action, name, except_fields)
        sanitized_schema = @schema.except(*except_fields)

        @context.def_param_group name do
          sanitized_schema.each do |param_name, info|
            type, required = info.values_at(:type, :required)
            options = info.slice(:desc, :base_class)
            options.merge!(required: required[action], default_value: nil)

            param(param_name, type, options)
          end
        end
      end
    end
  end
end
