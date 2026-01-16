FROM ruby:3.0.3

# Dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git \
  curl

# Define diretório de trabalho
WORKDIR /app

# Copia Gemfile primeiro (cache do bundle)
COPY Gemfile Gemfile.lock ./

# Instala bundler compatível
RUN gem install bundler -v "~> 2.3"

# Instala gems
RUN bundle install

# Copia o restante da aplicação
COPY . .

# Copia entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Expõe a porta padrão do Rails
EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]

# Comando padrão
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
