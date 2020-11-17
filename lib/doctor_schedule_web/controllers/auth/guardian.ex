defmodule DoctorScheduleWeb.Auth.Guardian do
  use Guardian, otp_app: :doctor_schedule

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Services.SessionService

  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  def resource_from_claims(claims) do
    {:ok,
     claims["sub"]
     |> AccountsRepository.get_user!()}
  end

  def authenticate(email, password) do
    SessionService.execute(email, password)
    |> case do
      {:ok, user} ->
        create_user(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp create_user(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
