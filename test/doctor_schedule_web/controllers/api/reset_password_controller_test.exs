defmodule DoctorScheduleWeb.Api.ResetPasswordControllerTest do
  use DoctorScheduleWeb.ConnCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Repositories.TokenRepository

  alias DoctorSchedule.UserFixture

  def fixture(:user) do
    {:ok, user} = AccountsRepository.create_user(UserFixture.valid_attrs())
    user
  end

  setup %{conn: conn} do
    {:ok,
     conn:
       conn
       |> put_req_header("accept", "application/json")}
  end

  test "should reset password", %{conn: conn} do
    {:ok, user} =
      %{
        email: "adm@test",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "123123",
        password_confirmation: "123123"
      }
      |> AccountsRepository.create_user()

    {:ok, token, _} = TokenRepository.generate(user.email)

    conn =
      post(conn, Routes.api_reset_password_path(conn, :create), %{
        token: token,
        data: %{
          password: "121212",
          password_confirmation: "121212"
        }
      })

    assert conn.status == 204
  end
end
