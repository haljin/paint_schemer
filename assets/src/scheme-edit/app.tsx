import "phoenix_html";

import React from "react";
import * as ReactDOM from "react-dom";
import { Provider } from "react-redux";
import { createStore } from "redux";
import { devToolsEnhancer } from "redux-devtools-extension";
import {
    loadScheme, UpdatePaintListAction,
    updatePaints, UpdatePaintTechniquesAction, updateTechniques,
} from "./actions";
import Scheme from "./components/scheme";
import reducer from "./state";

const mainStore = createStore(reducer, devToolsEnhancer({ name: "dev" }));
const mainNode = document.getElementById("react-main");

if (mainNode) {

    const paintPromise = getRequest("/api/paints")
        .then((data) => mainStore.dispatch(updatePaints(data)));
    const techniquePromise = getRequest("/api/paint_techniques")
        .then((data) => mainStore.dispatch(updateTechniques(data)));
    Promise.all<UpdatePaintListAction, UpdatePaintTechniquesAction>([paintPromise, techniquePromise])
        .then((_r1: any) => {
            const schemeId = (window as any).__SCHEME_ID__;
            if (!!schemeId) {
                getRequest(`/api/schemes/${schemeId}`)
                    .then((data) => mainStore.dispatch(loadScheme(data.sections, data.title, data.id)));
            }
        });

    ReactDOM.render(
        <Provider store={mainStore}>
            <Scheme />
        </Provider>, mainNode);
}

function getRequest(url: string) {
    return fetch(url)
        .then((resp) => resp.json())
        .then((json) => json.data);
}
