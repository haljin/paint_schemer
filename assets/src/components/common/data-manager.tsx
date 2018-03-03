import * as React from "react";
import { IDataEntry } from "../../data-types/response-types";
import DeleteButton from "./delete-button";
import DataEntryForm from "./entry-form";
import EntryList from "./list";

interface IProps {
    url: string;
    label?: string;
    selectedCallback?: (id: number) => void;
}
interface IState {
    selectedId?: number;
    data: IDataEntry[];
}
export default class DataManager<TProps extends IProps, TState extends IState> extends React.Component<TProps, TState> {
    public componentWillMount() {
        this.setState({ data: [] });
    }

    public componentDidMount() {
        this.refresh();
    }

    public render() {
        const rfshCallback = () => this.refresh();
        const selectCallback = (id: number) => this.entrySelected(id);
        return (
            <div>
                {this.props.label}
                <EntryList list={this.state.data} selectedCallback={selectCallback} />
                <DataEntryForm
                    url={this.props.url}
                    refreshCallback={rfshCallback}
                />

                <DeleteButton
                    url={this.props.url}
                    selectedId={this.state.selectedId}
                    refreshCallback={rfshCallback}
                />
            </div >);
    }

    protected entrySelected(id: number) {
        this.setState({ selectedId: id });
        if (this.props.selectedCallback) {
            this.props.selectedCallback(id);
        }
    }

    protected refresh() {
        this.getRequest(this.props.url)
            .then((data) => this.setState({ data }));
    }

    private getRequest(url: string) {
        return fetch(url)
            .then((resp) => resp.json())
            .then((json) => json.data);
    }
}
