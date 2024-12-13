defmodule GithubUsers.GithubAPI do
  require Logger

  def search_user(username) do
    url = "https://api.github.com/users/#{username}"

    headers = [
      {"User-Agent", "Elixir"},
      {"Accept", "application/vnd.github.v3+json"}
    ]

    case Finch.build(:get, url, headers) |> Finch.request(MyFinch) do
      {:ok, %Finch.Response{status: 200, body: data}} ->
        case Jason.decode(data) do
          {:ok, results} -> {:ok, results}
          {:error, reason} -> {:error, reason}
        end

      {:ok, %Finch.Response{status: status}} ->
        {:error, "GitHub API returned status #{status}"}

      {:error, reason} ->
        Logger.error("GitHub API request failed: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
