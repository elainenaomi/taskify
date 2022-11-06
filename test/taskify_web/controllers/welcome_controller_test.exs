defmodule TaskifyWeb.WelcomeControllerTest do
  use TaskifyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Taskify | My awesome task management!"
  end
end
