defmodule DoctorSchedule.Accounts.Services.SessionService do
  alias DoctorSchedule.Accounts.Entities.User
  alias DoctorSchedule.Repo

  def execute(email, password) do
    Repo.get_by(User, email: email)
    |> case do
      nil ->
        {:error, :not_found}

      user ->
        Argon2.verify_pass(password, user.password_hash)
        |> if do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end
end
