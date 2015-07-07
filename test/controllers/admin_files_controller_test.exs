defmodule Chen.AdminFilesControllerTest do
  use Chen.ConnCase

  alias Chen.AdminFiles
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, delid: "some content", dir: 42, expire: %{day: 17, month: 4, year: 2010}, hash: "some content", originalname: "some content", size: 42, user: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_files_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing files"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_files_path(conn, :new)
    assert html_response(conn, 200) =~ "New admin_files"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_files_path(conn, :create), admin_files: @valid_attrs
    assert redirected_to(conn) == admin_files_path(conn, :index)
    assert Repo.get_by(AdminFiles, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_files_path(conn, :create), admin_files: @invalid_attrs
    assert html_response(conn, 200) =~ "New admin_files"
  end

  test "shows chosen resource", %{conn: conn} do
    admin_files = Repo.insert %AdminFiles{}
    conn = get conn, admin_files_path(conn, :show, admin_files)
    assert html_response(conn, 200) =~ "Show admin_files"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    admin_files = Repo.insert %AdminFiles{}
    conn = get conn, admin_files_path(conn, :edit, admin_files)
    assert html_response(conn, 200) =~ "Edit admin_files"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    admin_files = Repo.insert %AdminFiles{}
    conn = put conn, admin_files_path(conn, :update, admin_files), admin_files: @valid_attrs
    assert redirected_to(conn) == admin_files_path(conn, :index)
    assert Repo.get_by(AdminFiles, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    admin_files = Repo.insert %AdminFiles{}
    conn = put conn, admin_files_path(conn, :update, admin_files), admin_files: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit admin_files"
  end

  test "deletes chosen resource", %{conn: conn} do
    admin_files = Repo.insert %AdminFiles{}
    conn = delete conn, admin_files_path(conn, :delete, admin_files)
    assert redirected_to(conn) == admin_files_path(conn, :index)
    refute Repo.get(AdminFiles, admin_files.id)
  end
end
