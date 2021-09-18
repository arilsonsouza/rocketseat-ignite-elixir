defmodule ExGithubWeb.Auth.AccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :ex_github

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
