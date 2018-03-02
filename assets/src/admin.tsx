import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";

class AdminPage extends React.Component<any, any> {
    public render() {
        return <div>Admin react Component</div>;
    }
}

function render(node) {
    ReactDOM.render(<AdminPage/>, node);
}

const main = document.getElementById("react-main");
if (main) {
    render(main);
}
