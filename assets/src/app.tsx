import "phoenix_html";

import React from "react";
import * as ReactDOM from "react-dom";
import { Provider } from "react-redux";
import { createStore } from "redux";
import { devToolsEnhancer } from "redux-devtools-extension";
import ConnectedMainComponent from "./scheme-edit/components/main";
import reducer from "./scheme-edit/state";

const mainStore = createStore(reducer, devToolsEnhancer({ name: "dev" }));
const mainNode = document.getElementById("react-main");

if (mainNode) {
    ReactDOM.render(
        <Provider store={mainStore}>
            <ConnectedMainComponent />
        </Provider>, mainNode);
}
