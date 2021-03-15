defmodule VeganismWeb.VeganLive do
  use VeganismWeb, :live_view
  alias Veganism.Items

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        food: "",
        items: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find Foods</h1>
    <div id="search">
      <div class="stores">
        <form phx-submit="food-search">
          <input type="text" name="food" value=""
                placeholder="Search for food"
                autofocus autocomplete="off"
                <%= if @loading, do: "readonly" %> />

          <button type="submit">submit</button>
        </form>
        <%= if @loading do %>
          <div class="loader">
            Loading...
          </div>
        <% end %>
        <div class="food">
          <ul>
            <%= for food <- @items do %>
            <div>
              <li>
                <%= food.brandOwner %>
              </li>
              <li>
                <%= food.ingredients %>
              </li>
              <li>
                <%= food.fdcId %>
              </li>
            </div>
            <% end %>
          </ul>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("food-search", %{"food" => food}, socket) do
    send(self(), {:run_food_search, food})

    socket =
      assign(socket,
        food: food,
        items: [],
        loading: true
      )

    {:noreply, socket}
  end

  @spec handle_info({:run_food_search, any}, any) :: {:noreply, any}
  def handle_info({:run_food_search, food}, socket) do
    case Items.search_by_name(food) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No food items matching #{food}")
          |> assign(items: [], loading: false)

        {:noreply, socket}

      items ->
        socket = assign(socket, items: items, loading: false)
        {:noreply, socket}
    end
  end
end
