defmodule DoctorSchedule.Accounts.Services.SessionServiceTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Services.SessionService
  alias DoctorSchedule.UserFixture

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(UserFixture.valid_attrs())
      |> AccountsRepository.create_user()

    user
  end

  test "execute/2 should return an user" do
    user = user_fixture()
    {:ok, auth_user} = SessionService.execute("test@test", "123123")
    assert user.email == auth_user.email
  end

  test "execute/2 unauthorized password invalid" do
    user_fixture()
    assert {:error, :unauthorized} == SessionService.execute("test@test", "12312")
  end

  test "execute/2 not found return" do
    assert {:error, :not_found} == SessionService.execute("test@fdfdfd", "12312")
  end
end
