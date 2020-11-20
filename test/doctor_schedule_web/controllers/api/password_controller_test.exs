defmodule DoctorScheduleWeb.Api.PasswordControllerTest do
  use DoctorScheduleWeb.ConnCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository

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

  test "should request to reset password", %{conn: conn} do
    {:ok, _user} =
      %{
        email: "adm@test",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "123123",
        password_confirmation: "123123"
      }
      |> AccountsRepository.create_user()

    conn = post(conn, Routes.api_password_path(conn, :create), email: "adm@test")

    assert conn.status == 204
  end
end
