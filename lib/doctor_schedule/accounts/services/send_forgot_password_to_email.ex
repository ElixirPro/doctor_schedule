defmodule DoctorSchedule.Accounts.Services.SendForgotPasswordToEmail do
  use Bamboo.Mailer, otp_app: :doctor_schedule
  use Bamboo.Phoenix, view: DoctorScheduleWeb.EmailView

  import Bamboo.Email

  alias DoctorSchedule.Accounts.Repositories.TokenRepository

  def execute(email) do
    email
    |> TokenRepository.generate()
    |> case do
      {:error, msg} ->
        {:error, msg}

      {:ok, token, user} ->
        {:ok, token, user, send_email(token, user)}
    end
  end

  defp send_email(token, user) do
    url = "http://localhost:4000/reset-password/#{token}"

    new_email()
    |> from({"Doctor Schedule Team", "adm@doctorschedule.com"})
    |> to({user.first_name, user.email})
    |> subject("[Doctor Schedule] - Password Recover")
    |> assign(:data, %{name: user.first_name, url: url})
    |> render("forgot-password.html")
    |> deliver_now()
  end
end
