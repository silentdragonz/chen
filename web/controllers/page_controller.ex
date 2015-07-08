defmodule Chen.PageController do
  use Chen.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def faq(conn, _params) do
    render conn, "faq.html"
  end

  def upload(conn, %{"files" => files}) do
    if is_nil(files) do
      json conn, %{error: "Error uploading files."}
    else
      f = hd(files)
      if File.exists?(f.path) do
        {:ok, cdn} = :application.get_env(:cdn)
        hash = hash_file(f.path)
        file_stat = File.stat!(f.path)

        q = from f in Chen.File,
          where: f.hash == ^hash and f.size == ^file_stat.size,
          limit: 1,
          select: f
        res = Repo.all(q)
        if length(res) > 0  do
          File.rm(f.path)
          matching_file = hd(res)
          filename = matching_file.filename
        else
          filename = f.filename
          |> Path.extname
          |> generate_name
          File.cp!(f.path, cdn[:cdn_path] <> "/" <> filename)
          File.rm(f.path)
          changeset = Chen.File.changeset(%Chen.File{}, %{originalname: f.filename, filename: filename, size: file_stat.size, hash: hash, date: Ecto.Date.local, delid: :crypto.hash(:sha, f.path) |> Base.encode16})
          if changeset.valid? do
            Repo.insert(changeset)
          end
        end

        message = %{filename: filename, url: cdn[:cdn_url]}
      else
        message = %{error: "File failed to upload. Please try again. (" <> f.filename <> ")"}
      end

      json conn, message 
    end
  end

  def generate_name(ext) do
    max_tries = Application.get_env(:chen, :cdn)
    filename = random_string(6) <> ext
    q = from f in Chen.File,
      where: f.filename == ^filename,
      limit: 1,
      select: f
    res = Repo.all(q)
    if length(res) > 0 do
      generate_name(ext)
    else
      filename
    end
  end

  def random_string(length) do
    :random.seed(:erlang.now())
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    alphabet_length = alphabet |> String.length
    1..length
     |> Enum.map_join fn(_) ->
       alphabet |> String.at :random.uniform( alphabet_length ) - 1
     end
  end

  def hash_file(file_path, hash_type \\ :sha) do
    sha = :crypto.hash_init(hash_type)
    File.stream!(file_path, [], 2048)
    |> Enum.reduce(sha, fn(buf, acc) ->
    :crypto.hash_update acc, buf
    end)
    |> :crypto.hash_final
    |> Base.encode16
    |> String.downcase
  end

end
