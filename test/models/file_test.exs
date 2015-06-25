defmodule Chen.FileTest do
  use Chen.ModelCase

  alias Chen.File

  @valid_attrs %{hash: "some content", originalname: "some content", filename: "some content", size: 12345, date: Ecto.Date.local, expire: Ecto.Date.local, delid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = File.changeset(%File{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = File.changeset(%File{}, @invalid_attrs)
    refute changeset.valid?
  end
end
