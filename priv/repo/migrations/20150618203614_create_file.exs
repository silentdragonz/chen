defmodule Chen.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :hash, :string
      add :originalname, :string
      add :filename, :string
      add :size, :integer
      add :date, :date
      add :expire, :date 
      add :delid, :string
      add :user, :integer
      add :dir, :integer
    end

  end
end
