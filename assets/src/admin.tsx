import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter as Router, Link, Route } from "react-router-dom";
import PaintsAdminFrame from "./components/admin/paints";
import UsersAdminFrame from "./components/admin/users";

class AdminPage extends React.Component<{ children?: React.ReactNode }, {}> {
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

const main = document.getElementById("react-main");
if (main) {
    ReactDOM.render(<AdminPage />, main);
}
