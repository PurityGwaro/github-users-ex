defmodule GithubUsers.Mocks do
  @moduledoc """
  Shared mock data for tests
  """
  def mock_user_data(username \\ "octocat") do
    %{
      "name" => "The Octocat",
      "login" => username,
      "avatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "bio" => "GitHub mascot",
      "public_repos" => 8,
      "followers" => 2000,
      "following" => 5,
      "created_at" => "2011-01-25T18:44:36Z",
      "location" => "San Francisco",
      "twitter_username" => "github",
      "blog" => "https://github.com/blog",
      "company" => "@github"
    }
  end

  def mock_user_with_nil_data(username \\ "octocat") do
    %{
      "name" => "The Octocat",
      "login" => username,
      "avatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "bio" => "GitHub mascot",
      "public_repos" => 8,
      "followers" => 2000,
      "following" => 5,
      "created_at" => "2011-01-25T18:44:36Z",
      "location" => nil,
      "twitter_username" => nil,
      "blog" => "",
      "company" => nil
    }
  end
end
