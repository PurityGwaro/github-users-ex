defmodule GithubUsersWeb.CardComponent do
  use GithubUsersWeb, :live_component

  attr :userDetails, :map,
    required: false,
    default: %{
      "name" => "Default User",
      "login" => "defaultuser",
      "created_at" => "2023-01-01T00:00:00Z",
      "bio" => "This is a default user bio.",
      "public_repos" => 0,
      "followers" => 0,
      "following" => 0,
      "location" => "Not Available",
      "twitter_username" => nil,
      "blog" => "https://www.gitsh",
      "company" => nil,
      "avatar_url" => "https://via.placeholder.com/117"
    }

  def card(assigns) do
    ~H"""
    <div class="flex flex-col lg:flex-row items-start justify-between rounded-[16px] bg-[#FEFEFE] dark:bg-[#1E2A47] md:px-16 lg:py-20 gap-10 py-10 w-full relative px-4">
      <img
        src={@userDetails["avatar_url"]}
        alt={@userDetails["name"]}
        class="rounded-[50%] md:w-[117px] md:h-[117px] h-[70px] w-[70px]"
      />
      <div class="flex flex-col lg:items-start lg:justify-center lg:w-[80%] gap-10 w-full">
        <div class="flex md:gap-2 gap-1 lg:gap-0 flex-col lg:flex-row lg:justify-between items-start top-10 left-28 md:left-60 md:top-12 absolute lg:static lg:w-full">
          <p class="flex flex-col lg:gap-3 md:gap-2 gap-1">
            <span class="md:text-[26px] text-[18px] font-bold dark:text-white">
              {@userDetails["name"]}
            </span>
            <span class="text-[#0079FF]">@{@userDetails["login"]}</span>
          </p>
          <p class="text-[#697C9A] md:text-[15px] text-[12px] dark:text-white">
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
        <div class="w-full grid grid-cols-2 gap-8 text-[15px] border">
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
