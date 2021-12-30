defmodule Samdelivery.User do
  use Ecto.Schema
  import Ecto.Changeset

  @fields_that_can_be_changed [
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :name,
    # altere password_hash para password.
    # o campo password_hash pode ser retirado
    # dos campos permitidos pois será utilizada
    # a função change para alterar o password_hash
    :password
  ]

  @required_fields [
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :name,
    # altere password_hash para password.
    # o password_hash só será alterado após as validações,
    # por isso deve ser retirado dos campos obrigatórios.
    :password
  ]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    # adicionando um campo virtual
    # o valor dele não será gravado no banco de dados
    # será apenas para capturar a senha do usuário
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> validate_length(:password_hash, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    # adicione a função para encriptar a senha
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  # caso o changeset seja 'valid?: false'
  defp put_pass_hash(changeset), do: changeset
end
