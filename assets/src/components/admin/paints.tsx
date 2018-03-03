import * as React from "react";
import { IManfacturerEntry, IPaintEntry, ITypeEntry } from "../../data-types/response-types";
import ExtendedEntryList from "../common/extended-list";
import DataManager from "./data-manager";

interface IState {
    manufacturers: IManfacturerEntry[];
    types: ITypeEntry[];
    paints: IPaintEntry[];
    selectedManufacturer: number | null;
    selectedType: number | null;
}
export default class PaintsAdminFrame extends React.Component<{}, IState> {
    constructor(props: {}) {
        super(props);
        this.state = { manufacturers: [], types: [], paints: [], selectedManufacturer: null, selectedType: null };
    }

    public render() {
        const manSelectCallback = (id: number) => this.setState({ selectedManufacturer: id });
        const typeSelectCallback = (id: number) => this.setState({ selectedType: id });
        return (
            <div>
                <DataManager
                    url="/api/paint_manufacturers"
                    label="Manufacturers"
                    selectedCallback={manSelectCallback}
                />
                <DataManager
                    url="/api/paint_types"
                    label="Types"
                    selectedCallback={typeSelectCallback}
                />
                Paints
                <ExtendedEntryList list={this.state.paints} />
            </div >);
    }

}
