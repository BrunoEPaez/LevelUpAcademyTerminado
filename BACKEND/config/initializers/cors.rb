Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Permitimos cualquier origen ('*') para que no importe 
    # si Cloudflare cambia el ID de tu URL en cada despliegue.
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      # Expose permite que el frontend pueda leer el token de respuesta si es necesario
      expose: ['Authorization']
  end
end