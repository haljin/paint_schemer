import "phoenix_html";

import React from "react";
import * as ReactDOM from "react-dom";
import MainView from "./main/components/main-view";

const mainNode = document.getElementById("react-main");

if (mainNode) {
    ReactDOM.render(
        <MainView />,
        mainNode,
    );
}
