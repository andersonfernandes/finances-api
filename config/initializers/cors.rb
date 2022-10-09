Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['CORS_ORIGINS'].split(',').map { |origin| origin.strip }

    resource '*', headers: :any, methods: :any, expose: ['WWW-Authenticate']
  end
end
