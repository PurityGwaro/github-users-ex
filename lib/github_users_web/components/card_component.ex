defmodule GithubUsersWeb.CardComponent do
  use GithubUsersWeb, :live_component

  attr :user_details, :map, required: true

  def card(assigns) do
    ~H"""
    <div
      id="card_component"
      class="flex flex-col lg:flex-row items-start justify-between rounded-[16px] bg-[#FEFEFE] dark:bg-[#1E2A47] md:px-16 lg:py-20 gap-10 py-10 w-full relative px-4 shadow-lg shadow-[#4660BB33] dark:shadow-none"
    >
      <img
        src={@user_details["avatar_url"]}
        alt={@user_details["name"]}
        class="rounded-[50%] md:w-[117px] md:h-[117px] h-[70px] w-[70px]"
      />
      <div class="flex flex-col lg:items-start lg:justify-center lg:w-[80%] gap-10 w-full">
        <div class="flex md:gap-2 gap-1 lg:gap-0 flex-col lg:flex-row lg:justify-between items-start top-10 left-28 md:left-60 md:top-12 absolute lg:static lg:w-full">
          <p class="flex flex-col lg:gap-3 md:gap-2 gap-1">
            <span id="card_name" class="md:text-[26px] text-[18px] font-bold dark:text-white">
              {@user_details["name"]}
            </span>
            <span id="card_username" class="text-[#0079FF]">@{@user_details["login"]}</span>
          </p>
          <p class="text-[#697C9A] md:text-[15px] text-[12px] dark:text-white">
            Joined {format_date(@user_details["created_at"])}
          </p>
        </div>
        <p class="text-[#4B6A9B] dark:text-white">{@user_details["bio"]}</p>
        <div class="flex items-center justify-between w-full bg-[#F6F8FF] dark:bg-[#141D2F] rounded-[16px] p-6">
          <.record_component title="Repos" value={@user_details["public_repos"]} />
          <.record_component title="Followers" value={@user_details["followers"]} />
          <.record_component title="Following" value={@user_details["following"]} />
        </div>
        <div class="w-[100%] grid md:grid-cols-2 gap-8 text-[15px]">
          <.info_component
            icon="hero-map-pin-solid"
            value={@user_details["location"]}
            class="location"
          />
          <.info_component
            icon="hero-x-mark-solid"
            value={@user_details["twitter_username"]}
            class="twitter"
          />
          <.info_component
            icon="hero-link-solid"
            value={@user_details["blog"]}
            class={["blog", @user_details["blog"] !== "" && "cursor-pointer hover:underline"]}
          />
          <.info_component
            icon="hero-building-office-2-solid"
            value={@user_details["company"]}
            class="company"
          />
        </div>
      </div>
    </div>
    """
  end

  attr :value, :integer, required: true
  attr :title, :string, required: true

  defp record_component(assigns) do
    ~H"""
    <p class="flex flex-col items-center justify-between">
      <span class="text-[13px] text-[#4B6A9B] dark:text-[#FFFFFF]">{@title}</span>
      <span class="text-[22px] font-bold dark:text-[#FFFFFF]">
        {@value}
      </span>
    </p>
    """
  end

  attr :value, :any, required: true
  attr :icon, :string, required: true
  attr :class, :any, required: false, default: nil

  defp info_component(assigns) do
    ~H"""
    <p class="flex items-start justify-start gap-4 w-full break-words overflow-hidden">
      <span>
        <.icon name={@icon} class="w-[20px] h-[20px] bg-[#4B6A9B]" />
      </span>
      <span class={[
        "text-[#4B6A9B] dark:text-[#FFFFFF]",
        @class
      ]}>
        <%= if @value in [nil, ""] do %>
          Not Available
        <% else %>
          <%= if String.contains?(@value, "http") do %>
            <a href={@value} target="_blank" class="hover:underline">
              {@value}
            </a>
          <% else %>
            {@value}
          <% end %>
        <% end %>
      </span>
    </p>
    """
  end

  defp format_date(date) do
    {:ok, datetime, _offset} = DateTime.from_iso8601(date)
    Calendar.strftime(datetime, "%d %b %Y")
  end
end
