defmodule DoctorSchedule.Accounts.Services.ResetPasswordServiceTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Repositories.TokenRepository
  alias DoctorSchedule.Accounts.Services.ResetPasswordService
  alias DoctorSchedule.UserFixture

  import Mock

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(UserFixture.valid_attrs())
      |> AccountsRepository.create_user()

    user
  end

  test "execute/2 should return token expired" do
    user = user_fixture()
    {:ok, token, _} = TokenRepository.generate(user.email)
    now = DateTime.utc_now()
    future_date = %{now | hour: now.hour + 5}

    with_mock DateTime, utc_now: fn -> future_date end do
      {:error, msg} =
        ResetPasswordService.execute(token, %{
          password: "121212",
          password_confirmation: "121212"
        })

      assert "Token has expired!" == msg
    end
  end

  test "execute/2 should reset password" do
    user = user_fixture()
    {:ok, token, _} = TokenRepository.generate(user.email)

    {:ok, msg} =
      ResetPasswordService.execute(token, %{
        password: "121212",
        password_confirmation: "121212"
      })

    assert "Password has updated!" == msg
  end

  test "execute/2 token does not exist" do
    {:error, msg} =
      ResetPasswordService.execute("2ed1fac2-4de4-4a10-a2a5-96e201b3002e", %{
        password: "121212",
        password_confirmation: "121212"
      })

    assert "Token does not exist" == msg
  end
end
