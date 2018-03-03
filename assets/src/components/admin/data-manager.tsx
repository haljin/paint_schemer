import * as React from "react";
import { IDataEntry } from "../../data-types/response-types";
import DeleteButton from "../common/delete-button";
import DataEntryForm from "../common/entry-form";
import EntryList from "../common/list";

interface IProps {
    url: string;
    label?: string;
    selectedCallback?: (id: number) => void;
}
interface IState {
    selectedId?: number;
    data: IDataEntry[];
}
export default class DataManager extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { data: [] };
    }

    public componentDidMount() {
        this.refresh();
    }

    public render() {
        const rfshCallback = () => this.refresh();
        const selectCallback = (id: number) => this.setState({ selectedId: id });
        return (
            <div>
                {this.props.label}
                <EntryList list={this.state.data} selectedCallback={selectCallback} />
                <DataEntryForm
                    url={this.props.url}
                    type="manufacturer"
                    refreshCallback={rfshCallback}
                />
                <DeleteButton
                    url={this.props.url}
                    selectedId={this.state.selectedId}
                    refreshCallback={rfshCallback}
                />
            </div >);
    }

    private getRequest(url: string) {
        return fetch(url)
            .then((resp) => resp.json())
            .then((json) => json.data);
    }

    private refresh() {
        this.getRequest(this.props.url)
            .then((data) => this.setState({ data }));
    }

}
