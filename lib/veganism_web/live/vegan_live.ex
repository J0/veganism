defmodule VeganismWeb.VeganLive do
  use VeganismWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find Foods</h1>
    <div id="search">
      <div class="stores">
        <form phx-submit="zip-search">
          <input type="text" name="food" value=""
                placeholder="Food"
                autofocus autocomplete="off"
                <%= if @loading, do: "readonly" %> />


          <button type="submit">submit</button>
        </form>
        <%= if @loading do %>
          <div class="loader">
            Loading...
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end
end
