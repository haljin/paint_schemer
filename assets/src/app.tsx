import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import MainComponent from "./components/main";

function render(node: HTMLElement) {
    ReactDOM.render(<MainComponent />, node);
}

const main = document.getElementById("react-main");
if (main) {
    render(main);
}
