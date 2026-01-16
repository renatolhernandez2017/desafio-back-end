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

# Expõe a porta padrão do Rails
EXPOSE 3000

# Comando padrão
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
