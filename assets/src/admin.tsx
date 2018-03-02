import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import { BrowserRouter as Router, Link, Route } from "react-router-dom";
import PaintsAdminFrame from "./components/admin/paints";
import UsersAdminFrame from "./components/admin/users";

class AdminPage extends React.Component<any, any> {
    public render() {
        return (
            <Router>
                <div>
                    <ul>
                        <li>
                            <Link to="/admin/paints">Paints</Link>
                        </li>
                        <li>
                            <Link to="/admin/users">Users</Link>
                        </li>
                    </ul>
                    <hr />
                    <Route path="/admin/paints" component={PaintsAdminFrame} />
                    <Route path="/admin/users" component={UsersAdminFrame} />
                </div>
            </Router>);
    }
}

function render(node) {
    ReactDOM.render(<AdminPage />, node);
}

const main = document.getElementById("react-main");
if (main) {
    render(main);
}
