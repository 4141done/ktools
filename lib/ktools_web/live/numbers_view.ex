defmodule KtoolsWeb.NumbersView do
  use Phoenix.LiveView

  alias Ktools.Numbers

  def render(assigns) do
    ~L"""
    <script>
      function copyResult() {
        var copyText = document.querySelector("#result-box");
        var copyButton = document.getElementById('copy-button');

        copyText.select();
        document.execCommand("copy");
        copyButton.innerHTML = '성공!';

        setTimeout(() => {
          copyButton.innerHTML = '복사';
        }, 1000);
      }
    </script>

    <div class="">
      <h1>한글 -> 숫자</h1>
      <div>
        <label for="한글">한글</label>
        <input type="text" phx-keyup="convert_number" phx-debounce="1000" name="한글" \>
      </div>

      <div>
        <h2>숫자</h2>
        <div>
          <input type="text" id="result-box" value="<%= @result %>" />
        </div>
        <button onclick="copyResult()" id="copy-button">복사</button>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, result: "")}
  end

  def handle_event("convert_number", %{"value" => value}, socket) do
    {:noreply, assign(socket, result: Numbers.to_int(value))}
  end
end