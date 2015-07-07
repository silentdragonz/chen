defmodule Chen.AdminFilesController do
  use Chen.Web, :controller

  plug :action

  def index(conn, _params) do
    files = Repo.all(Chen.File)
    {:ok, cdn} = :application.get_env(:cdn)
    render(conn, "index.html", %{files: files, cdn_url: cdn[:cdn_url]})
  end

  def grid(conn, _params) do
    files = Repo.all(Chen.File)
    {:ok, cdn} = :application.get_env(:cdn)
    :random.seed(:os.timestamp)
    render conn, "grid.html", %{files: Enum.shuffle(files), cdn_url: cdn[:cdn_url]}
  end

  def delete(conn, %{"id" => id}) do
    admin_files = Repo.get(Chen.File, id)
    {:ok, cdn} = :application.get_env(:cdn)
    #Repo.delete(admin_files)
    # Remove File
    file_path = cdn[:cdn_path] <> "/" <> admin_files.filename 
    #File.rm(file_path)

    conn
    |> put_flash(:info, "File deleted successfully.")
    |> redirect(to: admin_files_path(conn, :index))
  end
end
