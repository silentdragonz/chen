defmodule Chen.AdminControllerTest do
  use Chen.ConnCase

  alias Chen.Admin
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing admin"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_path(conn, :new)
    assert html_response(conn, 200) =~ "New admin"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @valid_attrs
    assert redirected_to(conn) == admin_path(conn, :index)
    assert Repo.get_by(Admin, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @invalid_attrs
    assert html_response(conn, 200) =~ "New admin"
  end

  test "shows chosen resource", %{conn: conn} do
    admin = Repo.insert %Admin{}
    conn = get conn, admin_path(conn, :show, admin)
    assert html_response(conn, 200) =~ "Show admin"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    admin = Repo.insert %Admin{}
    conn = get conn, admin_path(conn, :edit, admin)
    assert html_response(conn, 200) =~ "Edit admin"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    admin = Repo.insert %Admin{}
    conn = put conn, admin_path(conn, :update, admin), admin: @valid_attrs
    assert redirected_to(conn) == admin_path(conn, :index)
    assert Repo.get_by(Admin, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    admin = Repo.insert %Admin{}
    conn = put conn, admin_path(conn, :update, admin), admin: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit admin"
  end

  test "deletes chosen resource", %{conn: conn} do
    admin = Repo.insert %Admin{}
    conn = delete conn, admin_path(conn, :delete, admin)
    assert redirected_to(conn) == admin_path(conn, :index)
    refute Repo.get(Admin, admin.id)
  end
end
