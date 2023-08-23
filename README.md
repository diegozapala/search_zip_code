# Search Zip Code

Uma aplicação que retorna os dados de um endereço a partir do CEP informado.

## Dependências e Instalação

* Ruby 3.2.0

* Rails 7.0.6

* PostgreSQL

Para instalar as depêndencias do Search Zip Code e preparar para o uso, vá para a raiz do projeto e execute os comandos abaixo em seu terminal:

* Instalar todas as gems da aplicação:
```console
bundle install
```

* Criar a base de dados, adicionar todas as tabelas e executar alguns scripts para inicializar a aplicação:
```console
rake db:create db:migrate db:seed
```

* Adicionar todos os estados brasileiros à base dados:
```console
rake locations:update_states
```

* Adicionar todas as cidades brasileiras à base dados e víncular com os seus respectivos estados  :
```console
rake locations:update_cities
```

Agora crie um arquivo chamado `.env` na raiz do projeto e adicione a chave `AUTH_SECRET_KEY` seguindo o padrão do arquivo `.env_exemple`

## Como Executar

### Aplicação

Nossa aplicação já está pronta para ser iniciada e utilizada. Vá para a raiz do projeto e execute o comando abaixo em seu terminal:

```console
rails s
```

### Testes

Para executar os testes desta aplicação, vá para a raiz do projeto e execute o comando abaixo em seu terminal:

```console
rake spec
```

## Como Utilizar o Search Zip Code

O Search Zip Code é uma API Rest muito simples e funciona com apenas com dois tipos de verbos HTTP (Get e Post). Abaixo segue todas as instruções necessárias para encontrar o endereço a partir de um CEP.

### Autenticação

Para utilizar é necessário ter um usuário cadastrado e efetuar o login. O usuário pode ser criado diretamente no banco de dados ou para facilitar o processo, também pode utilizar o usuário préviamente criado no `seed` desta aplicação.

E-mail: joao.silva@teste.com
Senha: 123456

O login é efetuado a partir da rota `post` `/login`. Os dados de e-mail e senha devem ser enviados juntos nos `Headers` da requisição seguindo um padrão de autenticação básica. Abaixo segue um exemplo de como deve ser enviado.

`request.headers["Authorization"] = "Basic #{token}"` - (O `token` é a string `email:password` transformada com o modelo Base64)

### Busca pelo CEP

Para fazer uma busca de endereço a partir do CEP, basta acessar a rota `get` `/api/v1/:zip_code`, onde o `:zip_code` é o CEP formado por 8 dígitos numéricos sem espaço ou caracteres especiais.

Em conjunto com esta rota, nos `Headers` da requisição também é necessário enviar um `token` de autenticação. Este token é recebido na forma de um json no momento em que é feito o login e tem validade de 7 dias a partir do momento em que é gerado. Abaixo segue um exemplo de como deve ser enviado.

`request.headers["Authorization"] = "Bearer #{token}"` - (O `token` é a string recebida em um json quando é feito o login)

## Notas adicionais

Por fim, todas as respostas da aplicação são em json e a mesma foi desenvolvida pensando em performance e um código limpo e bem escrito.

