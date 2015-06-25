defmodule Chen.PageControllerTest do
  use Chen.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Honk! Honk!"
  end

  test "GET /faq" do
    conn = get conn(), "/faq"
    assert html_response(conn, 200) =~ "Chen does NOT"
  end
end
