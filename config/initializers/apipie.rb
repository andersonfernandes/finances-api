Apipie.configure do |config|
  config.app_name                = "Finances API"
  config.api_base_url            = ""
  config.doc_base_url            = "/apidoc"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false
end
