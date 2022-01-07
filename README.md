# API CRUD simples para controle de clientes.

Conjunto de dados básicos de um cliente:
- Razão Social
- Telefone
- Endereço
- Data de Cadastro
- Faturamento Declarado
- Dados bancários (Um cliente pode ter mais de um banco)
  - Banco
  - Agência
  - Conta

## Características
- Stack:
  - Ruby 3.0.2
  - Rails 7.0
  - Banco SQLite

## Descrição das APIs
  - Cliente:
    - Listar os clientes
      ```
      curl --location --request GET 'http://localhost:3000/api/v1/customers'
      ```
    - Adicionar um cliente
      ```
      curl --location --request POST 'http://localhost:3000/api/v1/customers' \
      --header 'Content-Type: application/json' \
      --data-raw '{
            "legal_name": "Fulano da silva",
            "phone_number": "(11) 98123-4567",
            "address": "Rua do cliente",
            "address_number": "1234",
            "complement": "Ap 134",
            "neighbourhood": "Bairro",
            "city": "São Paulo",
            "state": "SP",
            "postal_code": "66321123",
            "register_date": "2021-01-01",
            "declared_revenues": "12345.67"
        }'
      ```
    - Obter um cliente
      ```
      curl --location --request GET 'http://localhost:3000/api/v1/customers/:id'
      ```
    - Alterar um cliente
      ```
      curl --location --request PUT 'http://localhost:3000/api/v1/customers/:id' \
      --header 'Content-Type: application/json' \
      --data-raw '{
            "legal_name": "Fulano Ferreira da Silva",
            "phone_number": "(11) 98123-4567",
            "address": "Rua do Cliente",
            "address_number": "4321",
            "complement": "Ap 134",
            "neighbourhood": "Bairro Exemplo",
            "city": "Campinas",
            "state": "SP",
            "postal_code": "66321123",
            "register_date": "2021-01-01",
            "declared_revenues": "112345.67"
        }'
      ```
    - Excluir um cliente
      ```
      curl --location --request DELETE 'http://localhost:3000/api/v1/customers/:id'
      ```
  - Conta Bancária:
    - Listar as contas bancárias de um cliente
      ```
      curl --location --request GET 'http://localhost:3000/api/v1/customers/:customer_id/bank_accounts'
      ```
    - Adicionar uma conta bancária a um cliente
      ```
      curl --location --request POST 'http://localhost:3000/api/v1/customers/:customer_id/bank_accounts' \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "bank_code": "001",
          "agency_code": "2345X",
          "account_number": "12345678"
      }'
      ```
    - Obter uma conta bancária de um cliente
      ```
      curl --location --request GET 'http://localhost:3000/api/v1/customers/:customer_id/bank_accounts/:id' \
      ```
    - Alterar uma conta bancária de um cliente
      ```
      curl --location --request PUT 'http://localhost:3000/api/v1/customers/:customer_id/bank_accounts/:id' \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "bank_code": "001",
          "agency_code": "1234",
          "account_number": "12345678"
      }'
      ```
    - Excluir uma conta bancária de um cliente
      ```
      curl --location --request DELETE 'http://localhost:3000/api/v1/customers/:customer_id/bank_accounts/:id' \
      ```

## Instruções para executar a aplicação

### **Rails (Ambiente já configurado)**

Requisitos:
- Ruby 3.0.2
- Executar os comandos abaixo:
```
bundle install
rails db:migrate db:seed
```
Para rodar a aplicação
```
rails s -b 0.0.0.0
```

### **Docker**
Para criar imagem docker
```
docker build -t customers-api .
```

Para execução dos testes
```
docker run -it customers-api rails test -v -p
```

Para executar a aplicação
```
docker run -p 3000:3000 customers-api
```

Para execução para desenvolvimento com hot reloading do código

```
docker run -itP -v $(pwd):/var/app customers-api
```

### **Docker Composer**
Para criar imagem docker
```
docker-compose build
```

Para execução dos testes
```
docker-compose run --rm app rails test -v -p
```

Para executar a aplicação

1) Executar a criação das tabelas e população do bano com dados de teste
    ```
    docker-compose run --rm app rails db:migrate db:seed
    ```

2) Executar a aplicação
    ```
    docker-compose up
    ```
