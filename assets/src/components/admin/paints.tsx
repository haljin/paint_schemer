import * as React from "react";
import CreateForm from "../common/create-form";

export default class PaintsAdminFrame extends React.Component<null, null> {

    public render() {
        return (
            <div>
                Manufacturer
                <CreateForm url="/api/paint_manufacturers" type="manufacturer" />
                Types
                <CreateForm url="/api/paint_types" type="paint_type"/>
            </div>);
    }
}
