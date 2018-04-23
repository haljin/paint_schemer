import "phoenix_html";

import React from "react";
import * as ReactDOM from "react-dom";
import { Provider, Store } from "react-redux";
import { createStore } from "redux";
import { devToolsEnhancer } from "redux-devtools-extension";
import ConnectedMainComponent from "./scheme-edit/components/main";
import reducer, { ISchemeState } from "./scheme-edit/state";

function render(node: HTMLElement, store: Store<ISchemeState | undefined>) {
    ReactDOM.render(
        <Provider store={store}>
            <ConnectedMainComponent />
        </Provider>, node);
}
const mainStore = createStore(reducer, devToolsEnhancer({ name: "dev" }));

const main = document.getElementById("react-main");

if (main) {
    render(main, mainStore);
}
