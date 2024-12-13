defmodule GithubUsersWeb.CardComponent do
  use GithubUsersWeb, :live_component

  attr :userDetails, :map, required: true

  def card(assigns) do
    IO.inspect(assigns.userDetails, label: "USERNAME BEING PASSED######")

    ~H"""
    <div class="flex items-start justify-between rounded-[16px] bg-[#FEFEFE] dark:bg-[#1E2A47] px-16 py-20 gap-10">
      <img
        src={@userDetails["avatar_url"]}
        alt={@userDetails["name"]}
        class="rounded-[50%] w-[117px] h-[117px]"
      />
      <div class="flex flex-col items-start justify-center w-[80%] gap-10">
        <div class="flex justify-between items-start w-full">
          <p class="flex flex-col gap-3">
            <span class="text-[26px] font-bold dark:text-white">{@userDetails["name"]}</span>
            <span class="text-[#0079FF]">@{@userDetails["login"]}</span>
          </p>
          <p class="text-[#697C9A] text-[15px] dark:text-white">
            Joined {format_date(@userDetails["created_at"])}
          </p>
        </div>
        <p class="text-[#4B6A9B] dark:text-white">{@userDetails["bio"]}</p>
        <div class="flex items-center justify-between w-full bg-[#F6F8FF] dark:bg-[#141D2F] rounded-[16px] p-6">
          <p class="flex flex-col items-center justify-between">
            <span class="text-[13px] text-[#4B6A9B] dark:text-[#FFFFFF]">Repos</span>
            <span class="text-[22px] font-bold dark:text-[#FFFFFF]">
              <%= if @userDetails["public_repos"] == nil do %>
                -
              <% else %>
                {@userDetails["public_repos"]}
              <% end %>
            </span>
          </p>
          <p class="flex flex-col items-center justify-between">
            <span class="text-[13px] text-[#4B6A9B] dark:text-[#FFFFFF]">Followers</span>
            <span class="text-[22px] font-bold dark:text-[#FFFFFF]">
              <%= if @userDetails["followers"] == nil do %>
                -
              <% else %>
                {@userDetails["followers"]}
              <% end %>
            </span>
          </p>
          <p class="flex flex-col items-center justify-between">
            <span class="text-[13px] text-[#4B6A9B] dark:text-[#FFFFFF]">Following</span>
            <span class="text-[22px] font-bold dark:text-[#FFFFFF]">
              <%= if @userDetails["following"] == nil do %>
                -
              <% else %>
                {@userDetails["following"]}
              <% end %>
            </span>
          </p>
        </div>
        <div class="w-full grid grid-cols-2 gap-8 text-[15px]">
          <p class="flex items-start justify-start gap-4">
            <.icon name="hero-map-pin-solid" class="w-[20px] h-[20px] bg-[#4B6A9B]" />
            <span class="text-[#4B6A9B] dark:text-[#FFFFFF]">
              <%= if @userDetails["location"] == nil do %>
                Not Available
              <% else %>
                {@userDetails["location"]}
              <% end %>
            </span>
          </p>
          <p class="flex items-start justify-start gap-4">
            <.icon name="hero-link-solid" class="w-[20px] h-[20px] bg-[#4B6A9B]" />
            <span class="text-[#4B6A9B] dark:text-[#FFFFFF]">
              <%= if @userDetails["twitter_username"] == nil do %>
                Not Available
              <% else %>
                {@userDetails["twitter_username"]}
              <% end %>
            </span>
          </p>
          <p class="flex items-start justify-start gap-4">
            <.icon name="hero-link-solid" class="w-[20px] h-[20px] bg-[#697C9A]" />
            <span class="text-[#4B6A9B] dark:text-[#FFFFFF]">
              <%= if @userDetails["blog"] in [nil, ""] do %>
                Not Available
              <% else %>
                {@userDetails["blog"]}
              <% end %>
            </span>
          </p>
          <p class="flex items-start justify-start gap-4">
            <.icon name="hero-building-office-2-solid" class="w-[20px] h-[20px] bg-[#4B6A9B]" />
            <span class="text-[#4B6A9B] dark:text-[#FFFFFF]">
              <%= if @userDetails["company"] == nil do %>
                Not Available
              <% else %>
                {@userDetails["company"]}
              <% end %>
            </span>
          </p>
        </div>
      </div>
    </div>
    """
  end

  defp format_date(date) do
    {:ok, datetime, _offset} = DateTime.from_iso8601(date)
    Calendar.strftime(datetime, "%d %b %Y")
  end
end
