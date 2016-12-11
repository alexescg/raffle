defmodule Raffle.RaffleController do
  use Raffle.Web, :controller

  alias Raffle.Raffle

  def index(conn, _params, user) do
    raffles = Repo.all(user_raffles(user))
    render(conn, "index.html", raffles: raffles)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:raffles)
      |> Raffle.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"raffle" => raffle_params}, user) do
    changeset =
      user
      |> build_assoc(:raffles)
      |> Raffle.changeset(raffle_params)

    case Repo.insert(changeset) do
      {:ok, _raffle} ->
        conn
        |> put_flash(:info, "Raffle created successfully.")
        |> redirect(to: raffle_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    raffle = Repo.get!(user_raffles(user), id)
    render(conn, "show.html", raffle: raffle)
  end

  def edit(conn, %{"id" => id}, user) do
    raffle = Repo.get!(user_raffles(user), id)
    changeset = Raffle.changeset(raffle)
    render(conn, "edit.html", raffle: raffle, changeset: changeset)
  end

  def update(conn, %{"id" => id, "raffle" => raffle_params}, user) do
    raffle = Repo.get!(user_raffles(user), id)
    changeset = Raffle.changeset(raffle, raffle_params)

    case Repo.update(changeset) do
      {:ok, raffle} ->
        conn
        |> put_flash(:info, "Raffle updated successfully.")
        |> redirect(to: raffle_path(conn, :show, raffle))
      {:error, changeset} ->
        render(conn, "edit.html", raffle: raffle, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    raffle = Repo.get!(user_raffles(user), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(raffle)

    conn
    |> put_flash(:info, "Raffle deleted successfully.")
    |> redirect(to: raffle_path(conn, :index))
  end

def action(conn, _) do
  apply(__MODULE__, action_name(conn),
    [conn, conn.params, conn.assigns.current_user])
end

defp user_raffles(user) do
  assoc(user, :raffles)
end

end
