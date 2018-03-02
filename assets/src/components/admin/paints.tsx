import * as React from "react";
import DataManager from "../common/create-form";

export default class PaintsAdminFrame extends React.Component<null, null> {

    public render() {
        return (
            <div>
                Manufacturer
                <DataManager url="/api/paint_manufacturers" type="manufacturer" />
                Types
                <DataManager url="/api/paint_types" type="paint_type"/>
            </div>);
    }
}
