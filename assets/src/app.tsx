import "phoenix_html";

import React from "react";
import * as ReactDOM from "react-dom";
import SchemeList from "./main/components/scheme-list";

const mainNode = document.getElementById("react-main");

if (mainNode) {
    ReactDOM.render(
        <SchemeList />,
        mainNode,
    );
}
