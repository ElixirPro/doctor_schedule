defmodule DoctorScheduleWeb.Api.SessionController do
  use DoctorScheduleWeb, :controller


  alias DoctorScheduleWeb.Auth.Guardian

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do

      Guardian.authenticate(email, password)
      |> IO.inspect()


      conn
      |> put_status(:created)
      |> json(%{message: "123"})
  end

end
