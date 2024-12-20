defmodule GithubUsersWeb.UsersLive do
  use GithubUsersWeb, :live_view

  import GithubUsersWeb.CardComponent

  @impl true
  def mount(_params, _session, socket) do
    theme = get_connect_params(socket)["app-theme"] || :light

    {:ok,
     assign(socket,
       query: "",
       user_details: nil,
       error: nil,
       theme: theme
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-5 w-full md:w-[80%] lg:w-[100%] px-4">
      <section class="flex justify-between items-center">
        <h1 class="font-bold md:text-[26px] text-[#222731] dark:text-[#FFFFFF]" id="logo">
          devfinder
        </h1>
        <button
          class="flex justify-between items-center gap-4 dark:text-red-700"
          phx-click="toggle_theme"
          title="Toogle Theme"
          id="toggle_theme_btn"
        >
          <%= if @theme == :light do %>
            <p class="text-[13px] text-[#697C9A] dark:text-[#FFFFFF]">DARK</p>
            <.icon
              id="dark_theme_icon"
              name="hero-moon-solid"
              class="w-[20px] h-[20px] bg-[#697C9A] dark:bg-[#FFFFFF]"
            />
          <% else %>
            <p class="text-[13px] text-[#697C9A] dark:text-[#FFFFFF]">LIGHT</p>
            <.icon
              id="light_theme_icon"
              name="hero-sun-solid"
              class="w-[20px] h-[20px] bg-[#697C9A] dark:bg-[#FFFFFF]"
            />
          <% end %>
        </button>
      </section>
      <section class="relative mb-2">
        <.icon
          name="hero-magnifying-glass-solid"
          class="w-[24.06px] h-[24px] bg-[#0079FF] absolute top-5 md:top-7 lg:top-9 border left-2 md:left-6"
        />
        <form
          id="form_username"
          phx-submit="search"
          class="shadow-[#4660BB33] shadow-lg rounded-[15px] dark:shadow-none hover:shadow-xl transition ease-in-out duration-300"
        >
          <.input
            id="input_username"
            type="text"
            name="username"
            placeholder="Search Github username..."
            autocomplete="off"
            value={@query}
            phx-click="clear_error"
            phx-change={@query === "" && "clear_result"}
            class="rounded-[15px] text-[#4B6A9B] md:text-[14px] text-[11px] lg:text-[18px] font-[400] leading-[15px] pl-8 md:pl-16 bg-[#FEFEFE] md:py-5 lg:py-7 py-4  dark:text-[#FFFFFF] dark:bg-[#1E2A47] dark:placeholder-white cursor-pointer"
          />

          <.button
            id="search_button"
            type="submit"
            phx-disable-with="Searching..."
            class="lg:text-[16px] top-3 text-[12px] md:text-[14px] px-3 md:px-[24px] md:py-[8px] lg:py-[14px] absolute md:top-[17px] lg:top-[22px] right-2"
          >
            Search
          </.button>
          <%= if @error do %>
            <p class="text-red-500 absolute lg:top-9 lg:right-40 md:top-7 md:right-28 md:text-[12px] text-[11px] lg:text-[16px] ml-10 md:ml-0">
              {@error}
            </p>
          <% end %>
        </form>
      </section>
      <%= if @user_details do %>
        <section>
          <.card user_details={@user_details} />
        </section>
      <% end %>
    </div>
    """
  end

  def handle_event("clear_error", _, socket) do
    {:noreply, assign(socket, error: nil)}
  end

  def handle_event("clear_result", _, socket) do
    {:noreply, assign(socket, user_details: nil)}
  end

  @impl true
  def handle_event("search", %{"username" => username}, socket) do
    if username !== "" do
      case api_client().search_user(username) do
        {:ok, results} ->
          {:noreply, assign(socket, user_details: results, error: nil)}

        {:error, _error} ->
          {:noreply, assign(socket, error: "No results", user_details: nil)}
      end
    else
      {:noreply, assign(socket, error: "please enter a username", user_details: nil)}
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

  def api_client, do: Application.get_env(:github_users, :github_api, GithubUsers.GithubAPI)
end
