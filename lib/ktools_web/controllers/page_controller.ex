defmodule KtoolsWeb.PageController do
  use KtoolsWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _) do
    LiveView.Controller.live_render(conn, KtoolsWeb.NumbersView, session: %{})
  end
end
