defmodule DoctorScheduleWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DoctorScheduleWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(DoctorScheduleWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: message})

    # |> put_view(DoctorScheduleWeb.ErrorView)
    # |> render(:"404")
  end
end
