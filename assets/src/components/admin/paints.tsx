import * as React from "react";
import DataManager from "../common/data-manager";
import { EntryList } from "../common/list";
import { IManfacturerEntry, ITypeEntry } from "../../data-types/response-types";

interface IState {
    manufacturers: IManfacturerEntry[];
    types: ITypeEntry[];
}
export default class PaintsAdminFrame extends React.Component<{}, IState> {
    constructor(props: {}) {
        super(props);
        this.state = { manufacturers: [], types: [] };
    }

    private setManufacturers(data: IManfacturerEntry[]) {
        this.setState({ manufacturers: data });
    }
    private setTypes(data: ITypeEntry[]) {
        this.setState({ types: data });
    }

    public render() {
        return (
            <div>
                Manufacturer
                <DataManager url="/api/paint_manufacturers" type="manufacturer" dataCallback={this.setManufacturers.bind(this)}>
                    <EntryList list={this.state.manufacturers} />
                </DataManager>
                Types
                <DataManager url="/api/paint_types" type="paint_type" dataCallback={this.setTypes.bind(this)}>
                    <EntryList list={this.state.types} />
                </DataManager>
            </div >);
    }
}
