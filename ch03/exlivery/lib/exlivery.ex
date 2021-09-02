defmodule Exlivery do
  alias Exlivery.Users.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  def start_agents do
    UserAgent.start_link(nil)
  end

  defdelegate create_or_update_user(args), to: CreateOrUpdate, as: :call
end
