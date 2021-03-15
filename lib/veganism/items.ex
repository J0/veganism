defmodule Veganism.Items do
  import FdcEx

  def search_by_name(name) do
    :timer.sleep(1000)
    {:ok, res} = search(name)
    res.body |> Poison.decode!() |> extract_fields
  end

  defp extract_fields(res) do
    res["foods"]
    |> Enum.map(
      &%{brandOwner: &1["brandOwner"], fdcId: &1["fdcId"], ingredients: &1["ingredients"]}
    )
  end
end
