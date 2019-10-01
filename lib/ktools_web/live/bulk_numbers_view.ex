defmodule KtoolsWeb.BulkNumbersView do
  use Phoenix.LiveView

  alias Ktools.Numbers

  def render(assigns) do
    ~L"""
    <div class="">
      <h1>한글 -> 숫자</h1>
      <div>
        <label for="한글">한글</label>
        <textarea id="story" name="한글" phx-keyup="convert_number" phx-debounce="1000" rows="5" cols="33"></textarea>
      </div>

      <div>
        <h2>숫자</h2>
        <div>
          <textarea id="result" id="result-box" rows="5" cols="33"><%= @result %></textarea>
        </div>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, result: "")}
  end

  def handle_event("convert_number", %{"value" => value}, socket) do
    case Regex.named_captures(~r/(?<sep>\,|\n)/, value) do
      %{"sep" => sep} ->
        result = value
        |> String.split(sep)
        |> Enum.filter(fn
          nil -> false
          "" -> false
          _ -> true
         end)
        |> Numbers.bulk_to_int()
        |> Enum.join(sep)

        {:noreply, assign(socket, result: result)}

      nil ->
        {:noreply, assign(socket, result: Numbers.to_int(value))}
    end
  end
end