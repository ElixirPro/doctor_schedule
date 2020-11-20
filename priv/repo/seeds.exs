# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DoctorSchedule.Repo.insert!(%DoctorSchedule.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%{
  "email" => "test@test",
  "first_name" => "Gustavo",
  "last_name" => "Oliveira",
  "password" => "123123",
  "password_confirmation" => "123123"
}
|> DoctorSchedule.Accounts.Repositories.AccountsRepository.create_user()
