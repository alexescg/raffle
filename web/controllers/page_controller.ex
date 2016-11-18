defmodule Raffle.PageController do
  use Raffle.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
