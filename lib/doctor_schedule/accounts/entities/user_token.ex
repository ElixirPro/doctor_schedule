defmodule DoctorSchedule.Accounts.Entities.UserToken do
  use Ecto.Schema
  alias DoctorSchedule.Accounts.Entities.User
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "user_tokens" do
    field :token, Ecto.UUID, autogenerate: true
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:token, :user_id])
    |> validate_required([
      :user_id
    ])
  end
end
