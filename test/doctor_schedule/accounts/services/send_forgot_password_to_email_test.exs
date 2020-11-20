defmodule DoctorSchedule.Accounts.Services.SendForgotPasswordToEmailTest do
  use DoctorSchedule.DataCase

  use Bamboo.Test

  alias DoctorSchedule.Accounts.Repositories.AccountsRepository
  alias DoctorSchedule.Accounts.Services.SendForgotPasswordToEmail
  alias DoctorSchedule.UserFixture

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(UserFixture.valid_attrs())
      |> AccountsRepository.create_user()

    user
  end

  test "execute/1 should send email to reset password" do
    user = user_fixture()

    {:ok, _token, _user, sent_email} = SendForgotPasswordToEmail.execute(user.email)
    assert {"Doctor Schedule Team", "adm@doctorschedule.com"} == sent_email.from
    assert [{"some first_name", "test@test"}] == sent_email.to
    assert sent_email.html_body =~ "first_name"
    assert_delivered_email(sent_email)
  end

  test "execute/1 should not reset password" do
    assert {:error, "User does not exist"} == SendForgotPasswordToEmail.execute("invalid@email")
  end
end
