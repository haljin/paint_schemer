import * as React from "react";
import { IManfacturerEntry, IPaintEntry, ITypeEntry } from "../../data-types/response-types";
import DeleteButton from "../common/delete-button";
import DataEntryForm from "../common/entry-form";
import ExtendedEntryList from "../common/extended-list";
import EntryList from "../common/list";

interface IState {
    manufacturers: IManfacturerEntry[];
    types: ITypeEntry[];
    paints: IPaintEntry[];
}
export default class PaintsAdminFrame extends React.Component<{}, IState> {
    constructor(props: {}) {
        super(props);
        this.state = { manufacturers: [], types: [], paints: [] };
    }

    public componentDidMount() {
        this.refreshManufacturers();
        this.refreshTypes();
        this.refreshPaints();
    }

    public render() {
        const manCallback = () => this.refreshManufacturers();
        const typeCallback = () => this.refreshTypes();
        return (
            <div>
                Manufacturers
                <EntryList list={this.state.manufacturers} />
                <DataEntryForm
                    url="/api/paint_manufacturers"
                    type="manufacturer"
                    refreshCallback={manCallback}
                />
                <DeleteButton url="/api/paint_manufacturers/" selectedId={3} refreshCallback={manCallback} />
                Types
                <EntryList list={this.state.types} />
                <DataEntryForm
                    url="/api/paint_types"
                    type="paint_type"
                    refreshCallback={typeCallback}
                />
                Paints
                <ExtendedEntryList list={this.state.paints} />
            </div >);
    }

    private getRequest(url: string) {
        return fetch(url)
            .then((resp) => resp.json())
            .then((json) => json.data);
    }

    private refreshManufacturers() {
        this.getRequest("/api/paint_manufacturers")
            .then((data) => this.setState({ manufacturers: data }));
    }

    private refreshTypes() {
        this.getRequest("/api/paint_types")
            .then((data) => this.setState({ types: data }));
    }

    private refreshPaints() {
        this.getRequest("/api/paints")
            .then((data) => this.setState({ paints: data }));
    }
}
