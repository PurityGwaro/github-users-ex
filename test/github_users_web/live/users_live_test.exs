defmodule GithubUsersWeb.UsersLiveTest do
  alias GithubUsers.Mocks
  use GithubUsersWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  describe "initial render" do
    test "devfinder logo is displayed", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      assert has_element?(
               view,
               "#logo",
               "devfinder"
             )
    end

    test "toggle theme works as expected", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      assert view |> element("#dark_theme_icon") |> has_element?()
      assert view |> element("#toggle_theme_btn") |> render() =~ "DARK"
      view |> element("#toggle_theme_btn") |> render_click()
      assert view |> element("#light_theme_icon") |> has_element?()
      assert view |> element("#toggle_theme_btn") |> render() =~ "LIGHT"
    end

    test "input element is shown with the correct placeholder text", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      assert view
             |> element("#input_username")
             |> render() =~ "placeholder=\"Search Github username...\""

      assert has_element?(
               view,
               "[id=input_username]"
             )

      assert has_element?(
               view,
               "[id=search_button]"
             )
    end
  end

  describe "user search" do
    test "searching empty input shows an error", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      view
      |> form("#form_username", %{"username" => ""})
      |> render_submit()

      assert has_element?(view, "p", "please enter a username")
    end

    test "display user details on successfull search", %{conn: conn} do
      mock_data = Mocks.mock_user_data("octocat")

      ApiClientBehaviourMock
      |> expect(:search_user, fn "octocat" -> {:ok, mock_data} end)

      {:ok, view, _html} = live(conn, ~p"/")

      view
      |> form("#form_username", %{"username" => "octocat"})
      |> render_submit()

      assert has_element?(view, "#card_component")
      assert has_element?(view, "#card_name", mock_data["name"])
      assert has_element?(view, "#card_username", mock_data["login"])
    end

    test "should show not available on fields that come out nil or empty string", %{conn: conn} do
      mock_data = Mocks.mock_user_with_nil_data("octocat")

      ApiClientBehaviourMock
      |> expect(:search_user, fn "octocat" -> {:ok, mock_data} end)

      {:ok, view, _html} = live(conn, ~p"/")

      view
      |> form("#form_username", %{"username" => "octocat"})
      |> render_submit()

      assert has_element?(view, ".location", "Not Available")
      assert has_element?(view, ".twitter", "Not Available")
      assert has_element?(view, ".blog", "Not Available")
      assert has_element?(view, ".company", "Not Available")
    end

    test "should show No results for user that's not available", %{conn: conn} do
      ApiClientBehaviourMock
      |> expect(:search_user, fn "octocat45678909iuytfghuji" -> {:error, "No Results"} end)

      {:ok, view, _html} = live(conn, ~p"/")

      view
      |> form("#form_username", %{"username" => "octocat45678909iuytfghuji"})
      |> render_submit()

      assert has_element?(view, "p", "No results")
    end
  end
end
