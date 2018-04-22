import * as React from "react";
import { IManfacturerEntry, IPaintEntry, ITypeEntry } from "../../data-types/response-types";
import DataManager from "../common/data-manager";
import PaintManager from "./paint-manager";

interface IState {
    manufacturers: IManfacturerEntry[];
    types: ITypeEntry[];
    paints: IPaintEntry[];
    selectedManufacturer?: number;
    selectedType?: number;
}
export default class PaintsAdminFrame extends React.Component<{}, IState> {
    constructor(props: {}) {
        super(props);
        this.state = { manufacturers: [], types: [], paints: [] };
    }

    public render() {
        const manSelectCallback = (id: number) => this.setState({ selectedManufacturer: id });
        const typeSelectCallback = (id: number) => this.setState({ selectedType: id });
        return (
            <div>
                <DataManager
                    url="/api/paint_technique"
                    label="Techniques"
                />
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
                <PaintManager
                    url="/api/paints"
                    label="Paints"
                    selectedManufacturer={this.state.selectedManufacturer}
                    selectedType={this.state.selectedType}
                />
            </div >);
    }

}
