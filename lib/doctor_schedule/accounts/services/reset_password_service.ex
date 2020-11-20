defmodule DoctorSchedule.Accounts.Services.ResetPasswordService do
  use Bamboo.Mailer, otp_app: :doctor_schedule
  use Bamboo.Phoenix, view: DoctorScheduleWeb.EmailView

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Repositories.TokenRepository

  @token_time 2

  def execute(token, data) do
    token
    |> TokenRepository.get_by_token()
    |> case do
      nil ->
        {:error, "Token does not exist"}

      user_token ->
        user_token
        |> validate_token()
        |> case do
          true ->
            user_token.user
            |> AccountsRepository.update_user(data)

            {:ok, "Password has updated!"}

          false ->
            {:error, "Token has expired!"}
        end
    end
  end

  defp validate_token(user_token) do
    user_token.inserted_at
    |> is_valid_token?
  end

  defp is_valid_token?(token_inserted) do
    valid_period = token_inserted.hour + @token_time
    DateTime.utc_now().hour < valid_period
  end
end
