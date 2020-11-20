defmodule DoctorSchedule.Accounts.Repositories.TokenRepositoryTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Repositories.TokenRepository
  alias DoctorSchedule.UserFixture

  describe "users" do

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(UserFixture.valid_attrs())
        |> AccountsRepository.create_user()

      user
    end

    test "get_by_token/1 should return a token" do
      user = user_fixture()
      {:ok, token, _user} = TokenRepository.generate(user.email)
      assert token == TokenRepository.get_by_token(token).token
    end

    test "generate/1 should create a user token" do
      user = user_fixture()
      {:ok, token, user_token} = TokenRepository.generate(user.email)
      assert token == TokenRepository.get_by_token(token).token
      assert user.first_name == user_token.first_name
    end

    test "generate/1 should return error" do
      assert {:error, "User does not exist"} == TokenRepository.generate("sdf@12sdfsd")
    end

  end
end
