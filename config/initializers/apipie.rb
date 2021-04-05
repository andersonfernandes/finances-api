Apipie.configure do |config|
  config.app_name                = 'Finances API'
  config.app_info                = 'Financial management API'
  config.doc_base_url            = '/documentation'
  config.api_base_url            = ''
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false

  config.swagger_content_type_input = :json
  config.swagger_api_host           = 'financesapi.herokuapp.com'
end
