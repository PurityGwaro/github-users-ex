defmodule GithubUsers.GithubAPIBehaviour do
  @moduledoc """
  It defines the behviour of the github api used to search for a single user by username
  """
  @callback search_user(String.t()) :: {:ok, map()} | {:error, any()}
end
