# Rack CORS Middleware used for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible.

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete]
  end
end
