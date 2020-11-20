defmodule DoctorSchedule.Accounts.Repositories.AccountsRepositoryTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.UserFixture

  describe "users" do
    alias DoctorSchedule.Accounts.Entities.User

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(UserFixture.valid_attrs())
        |> AccountsRepository.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user_fixture()
      assert AccountsRepository.list_users() |> Enum.count() == 1
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert AccountsRepository.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = AccountsRepository.create_user(UserFixture.valid_attrs())
      assert user.email == "test@test"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.role == "user"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               AccountsRepository.create_user(UserFixture.invalid_attrs())
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} =
               AccountsRepository.update_user(user, UserFixture.update_attrs())

      assert user.email == "test@test"
      assert user.first_name == "update"
      assert user.last_name == "update last name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AccountsRepository.update_user(user, UserFixture.invalid_attrs())

      assert user.email == AccountsRepository.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = AccountsRepository.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> AccountsRepository.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = AccountsRepository.change_user(user)
    end
  end
end
