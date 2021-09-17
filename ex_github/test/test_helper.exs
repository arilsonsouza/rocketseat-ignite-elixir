ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ExGithub.Repo, :manual)

Mox.defmock(ExGithub.Api.ClientMock, for: ExGithub.Api.ClientBehaviour)
