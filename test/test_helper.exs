Mox.defmock(ApiClientBehaviourMock, for: GithubUsers.GithubAPIBehaviour)
Application.put_env(:github_users, :github_api, ApiClientBehaviourMock)
ExUnit.start()
