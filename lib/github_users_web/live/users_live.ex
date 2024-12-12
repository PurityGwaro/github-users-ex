defmodule GithubUsersWeb.UsersLive do
  use GithubUsersWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :count, 0)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="text-[40px] flex flex-col justify-center items-center gap-4">
      <h1>count {@count}</h1>
      <button class="border p-4" phx-click="increase">+</button>
      <button class="border p-4" phx-click="decrease">-</button>
    </div>
    """
  end

  def handle_event("increase", _params, socket) do
    count = socket.assigns.count + 1
    socket = assign(socket, :count, count)
    {:noreply, socket}
  end

  def handle_event("decrease", _params, socket) do
    count = socket.assigns.count - 1
    socket = assign(socket, :count, count)
    {:noreply, socket}
  end
end
