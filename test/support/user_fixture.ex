defmodule DoctorSchedule.UserFixture do
  def valid_attrs,
    do: %{
      email: "test@test",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "123123",
      password_confirmation: "123123"
    }

  def update_attrs,
    do: %{
      email: "test@test",
      first_name: "update",
      last_name: "update last name",
      password: "123123",
      password_confirmation: "123123"
    }

  def invalid_attrs,
    do: %{
      email: nil,
      first_name: nil,
      last_name: nil,
      password: nil,
      password_confirmation: nil
    }
end
