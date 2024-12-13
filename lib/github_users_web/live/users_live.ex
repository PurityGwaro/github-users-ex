defmodule GithubUsersWeb.UsersLive do
  use GithubUsersWeb, :live_view

  import GithubUsersWeb.CardComponent
  alias GithubUsers.GithubAPI

  @impl true
  def mount(_params, _session, socket) do
    theme = get_connect_params(socket)["app-theme"] || :light

    {:ok,
     assign(socket,
       query: "",
       userDetails: nil,
       error: nil,
       theme: theme
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-5">
      <section class="flex justify-between items-center">
        <h1 class="font-bold text-[26px] text-[#222731] dark:text-[#FFFFFF]">devfinder</h1>
        <button
          class="flex justify-between items-center gap-4 dark:text-red-700"
          phx-click="toggle_theme"
          title="Toogle Theme"
        >
          <%= if @theme == :light do %>
            <p class="text-[13px] text-[#697C9A] dark:text-[#FFFFFF]">DARK</p>
            <.icon name="hero-moon-solid" class="w-[20px] h-[20px] bg-[#697C9A] dark:bg-[#FFFFFF]" />
          <% else %>
            <p class="text-[13px] text-[#697C9A] dark:text-[#FFFFFF]">LIGHT</p>
            <.icon name="hero-sun-solid" class="w-[20px] h-[20px] bg-[#697C9A] dark:bg-[#FFFFFF]" />
          <% end %>
        </button>
      </section>
      <section class="relative">
        <.icon
          name="hero-magnifying-glass-solid"
          class="w-[24.06px] h-[24px] bg-[#0079FF] absolute top-9 border left-6"
        />
        <form phx-submit="search">
          <.input
            type="text"
            name="username"
            placeholder="Search Github username..."
            value={@query}
            class="rounded-[15px] text-[#4B6A9B] text-[18px] font-[400] leading-[15px] pl-16 shadow-custom bg-[#FEFEFE] py-7 focus:ring-0 focus:outline-none dark:text-[#FFFFFF] dark:bg-[#1E2A47] dark:focus:bg-[#1E2A47]"
          />

          <.button type="submit" class="text-[16px] px-[24px] py-[14px] absolute top-[22px] right-2">
            SEARCH
          </.button>
        </form>
      </section>
      <%= if @error do %>
        <p class="text-red-500">{@error}</p>
      <% end %>
      <%= if @userDetails do %>
        <section>
          <.card userDetails={@userDetails} />
        </section>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("search", %{"username" => username}, socket) do
    case GithubAPI.search_user(username) do
      {:ok, results} ->
        {:noreply, assign(socket, userDetails: results, error: nil)}

      {:error, error} ->
        {:noreply, assign(socket, error: "Failed to fetch user: #{error}", userDetails: nil)}
    end
  end

  def handle_event("toggle_theme", _, socket) do
    new_theme = if socket.assigns.theme == :light, do: :dark, else: :light

    socket =
      socket
      |> assign(:theme, new_theme)
      |> push_event("update-theme", %{theme: new_theme})

    {:noreply, socket}
  end
end
