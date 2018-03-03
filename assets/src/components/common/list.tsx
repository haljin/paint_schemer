import * as React from "react";
import { IDataEntry } from "../../data-types/response-types";

interface IProps {
    children?: React.ReactNode;
    list: IDataEntry[];
    selectedCallback?: (id: number) => void;
}

interface IState {
    selected: number | null;
}

export default class EntryList<TProps extends IProps, TState extends IState> extends React.Component<TProps, TState> {
    public componentWillMount() {
        this.setState({ selected: null });
    }

    public render() {
        const entries = this.props.list.map((entry, i) => {
            const clickFun = () => this.clicked(entry);
            const className = this.state.selected === entry.id ? "selected" : "";
            return <li className={className} onClick={clickFun} key={i}>{entry.name}</li>;
        });
        return <ul> {entries} </ul>;
    }

    protected clicked(entry: IDataEntry) {
        this.setState({ selected: entry.id });
        if (this.props.selectedCallback) {
            this.props.selectedCallback(entry.id);
        }
    }

}
