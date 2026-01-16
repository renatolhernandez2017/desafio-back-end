# 🖥️ Desafio Back-end

## 📌 Introdução

Sobre o desafio e os entregáveis seguintes:

Refatoração do código de criação de conta, que está complexo
criação de testes unitários para os trechos de código que estão sem cobertura
criação de uma nova funcionalidade.

---

## Como rodar localmente

Você vai precisar:
* docker
* docker-compose
* ruby 3.0.3

No terminal:
Clonar o projeto via https ou ssh

- HTTPS -> git clone https://github.com/renatolhernandez2017/desafio-back-end.git
- SSH -> git@github.com:renatolhernandez2017/desafio-back-end.git

Acessar pasta:
  - cd desafio-back-end

Para subir o projeto, abra o terminal:
  - docker-compose down
  - docker-compose build --no-cache
  - docker-compose up

Os comandos acima vão:
 - Subir a aplicação
 - Criar o banco de dados
 - Gerar as migrations

---

## ▶️ Para rodar os testes

Abra uma nova aba no terminal e execute:
 - docker-compose exec app bash
 - rails db:test:prepare
 - rails parallel:create
 - COVERAGE=true parallel_rspec spec -n 4 ou rspec

---

## API
### Registration

```http
POST /api/v1/registrations
```

### Body
```json
{
  "account": {
    "name": "Grupo ABC",
    "entities": [
      {
        "name": "Empresa A",
        "users": [
          {
            "email": "users@test.com",
            "first_name": "User",
            "last_name": "Test",
            "phone": "1197523658"
          }
        ]
      },
      {
        "name": "Empresa B",
        "users": [
          {
            "email": "users@test.com",
            "first_name": "User",
            "last_name": "Test",
            "phone": "1197523658"
          }
        ]
      }
    ]
  }
}
```

### Para testar via terminal
copiar e colar o CURL a seguir:

```
curl --location 'localhost:3000/api/v1/registrations' \
--header 'Content-Type: application/json' \
--data-raw '{
  "account": {
    "name": "Grupo ABC",
    "entities": [
      {
        "name": "Empresa A",
        "users": [
          {
            "email": "users@test.com",
            "first_name": "User",
            "last_name": "Test",
            "phone": "1197523658"
          }
        ]
      },
      {
        "name": "Empresa B",
        "users": [
          {
            "email": "users@test.com",
            "first_name": "User",
            "last_name": "Test",
            "phone": "1197523658"
          }
        ]
      }
    ]
  }
}
'
```

#### Response
##### Success
```json
{
  "message": "Registro realizado com sucesso"
}
```
##### Error
```json
{
  "error": "Nome não pode ficar em branco"
}
```
