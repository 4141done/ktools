// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

const Hooks = {};

Hooks.CopyTarget = {
  mounted() {
    this.el.addEventListener('click', e => {
      const resultId = this.el.getAttribute('data-result-id');
      const copySource = document.querySelector(`#${resultId}`);
      const copyButtonOriginalText = this.el.innerHTML;
      const successText = this.el.getAttribute('data-success-text');

      copySource.select();
      document.execCommand("copy");

      if (successText) {
        this.el.innerHTML = successText;

        setTimeout(() => {
          this.el.innerHTML = copyButtonOriginalText;
        }, 1000);
      }
    });
  }
};

import {Socket} from "phoenix";
import LiveSocket from "phoenix_live_view";

let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks});
liveSocket.connect();

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
