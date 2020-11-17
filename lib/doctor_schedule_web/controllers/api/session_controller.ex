defmodule DoctorScheduleWeb.Api.SessionController do
  use DoctorScheduleWeb, :controller

  alias DoctorScheduleWeb.Api.UserView
  alias DoctorScheduleWeb.Auth.Guardian

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> json(%{user: UserView.render("user.json", %{user: user}), token: token})
    end
  end
end
