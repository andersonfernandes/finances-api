module Api
  module V1
    module User
      module Response
        def self.included(base_class)
          base_class.include Api::V1::Account::Response
          base_class.def_param_group :user_response do
            property :email, String, desc: 'User email'
            property :name, String, desc: 'User name'
            property(:default_account, Hash) { param_group :account_response, base_class }
          end
        end
      end
    end
  end
end
