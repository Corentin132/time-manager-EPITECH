defmodule Utils do
  @moduledoc """
  Utility functions
  """
  @uuid_regex ~r/^[a-f\d]{8}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{12}$/i

  def valid_uuid?(str) do
    String.match?(str, @uuid_regex)
  end
end
