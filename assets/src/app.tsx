import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import MainComponent from "./main";

function render(node) {
    ReactDOM.render(<MainComponent/>, node);
}

const main = document.getElementById("react-main");
if (main) {
    render(main);
}
