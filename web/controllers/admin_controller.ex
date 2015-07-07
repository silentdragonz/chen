defmodule Chen.AdminController do
  use Chen.Web, :controller

  alias Chen.Admin

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

end
