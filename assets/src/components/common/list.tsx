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

export default class EntryList extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { selected: null };
    }

    public render() {
        const entries = this.props.list.map((entry, i) => {
            const clickFun = () => this.clicked(entry);
            const style = { background: this.state.selected === entry.id ? "red" : "none" };
            return <li style={style} onClick={clickFun} key={i}>{entry.name}</li>;
        });
        return <ul> {entries} </ul>;
    }

    private clicked(entry: IDataEntry) {
        this.setState({ selected: entry.id });
        if (this.props.selectedCallback) {
            this.props.selectedCallback(entry.id);
        }
    }

}
