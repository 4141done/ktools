defmodule KtoolsWeb.PageControllerTest do
  use KtoolsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "한글 -> 숫"
  end
end
