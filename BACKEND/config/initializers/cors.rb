Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://a04651b3.levelupacademyterminado.pages.dev" # El puerto donde corre tu React
    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end