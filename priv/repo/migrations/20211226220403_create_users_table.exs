defmodule Samdelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

   def change do
    # A convenção no `Ecto` é pluralizar o nome das tabelas,
    # portanto, vamos nomear a nossa tabela como :users.
    create table :users do
      # o id é gerado automaticamente então não precisamos criar
      add :address,        :string
      add :age,            :integer
      add :cep,            :string
      add :cpf,            :string
      add :email,          :string
      add :name,           :string
      add :password_hash,  :string
      # Precisamos do password nomeado como password_hash 
      # pois vamos criptografar a senha do usuário...

      # essa função de timestamps gera automaticamente os campos
      # inserted_at para guardar a hora de criação do registro
      # e updated_at para guardar a hora da atualização do registro
      timestamps()
    end

    # O índice unique não deixará o cpf do usuário se repetir
    create unique_index(:users, [:cpf])
    # E também não deixará o email do usuário se repetir,
    create unique_index(:users, [:email])
    # ou seja, esses dois campos serão únicos


    # Por curiosidade, existe também esse formato:
    # create index("users", [:email], unique: true)
  end
end
