defmodule DoctorScheduleWeb.Api.SessionControllerTest do
  use DoctorScheduleWeb.ConnCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository

  alias DoctorSchedule.UserFixture

  import DoctorScheduleWeb.Auth.Guardian

  def fixture(:user) do
    {:ok, user} = AccountsRepository.create_user(UserFixture.valid_attrs())
    user
  end

  setup %{conn: conn} do
    {:ok, user} = %{
      email: "adm@test",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "123123",
      password_confirmation: "123123"
    }
    |> AccountsRepository.create_user()

    {:ok, token, _claims} = encode_and_sign(user, %{}, token_type: :access)

    {:ok, conn:
    conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "bearer " <> token)
  }
  end


  describe "session tests" do
    test "it should authneticate with valid user", %{conn: conn} do
      conn = post(conn, Routes.api_session_path(conn, :create), email: "adm@test", password: "123123")

      assert "adm@test" = json_response(conn, 201)["user"]["email"]
    end

    test "it should not authenticate with invalid user", %{conn: conn} do
      conn = post(conn, Routes.api_session_path(conn, :create), email: "adm@te", password: "123323")

      assert %{"message" => "unauthorized"} = json_response(conn, 400)
    end
  end

end
