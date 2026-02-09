# Usa una imagen de Ruby estable
FROM ruby:3.2.2

# Instalamos dependencias del sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Directorio de trabajo
WORKDIR /app

# Copiamos las gemas primero para aprovechar la caché de Docker
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiamos el resto del código
COPY . .

# Script para manejar el puerto dinámico de Koyeb/Render
EXPOSE 3000

# Comando para iniciar el servidor usando la variable de entorno PORT

# Cambia la última línea (el CMD) por esto:
# En la última línea de tu Dockerfile
CMD ["sh", "-xc", "bundle exec rake db:migrate && bundle exec rake db:seed && bundle exec puma -C config/puma.rb"]