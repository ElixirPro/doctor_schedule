defmodule DoctorScheduleWeb.Api.UserController do
  use DoctorScheduleWeb, :controller

  alias DoctorSchedule.Accounts.Entities.User
  alias DoctorSchedule.Accounts.Repositories.AccountsRepository

  action_fallback DoctorScheduleWeb.FallbackController

  def index(conn, _params) do
    users = AccountsRepository.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- AccountsRepository.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = AccountsRepository.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = AccountsRepository.get_user!(id)

    with {:ok, %User{} = user} <- AccountsRepository.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = AccountsRepository.get_user!(id)

    with {:ok, %User{}} <- AccountsRepository.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
