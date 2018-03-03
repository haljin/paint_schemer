import * as React from "react";
import { IPaintEntry } from "../../data-types/response-types";

interface IProps {
    list: IPaintEntry[];
    selectedCallback?: (id: number) => void;
    children?: React.ReactNode;
}

interface IState {
    selected: number | null;
}

export default class ExtendedEntryList extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { selected: null };
    }

    public render() {
        const rows = this.props.list.map((entry, i) => {
            const className = this.state.selected === entry.id ? "selected" : "";
            const clickFun = () => this.clicked(entry);
            return (
                <tr className={className} onClick={clickFun} key={i}>
                    <td>{entry.name}</td>
                    <td>{entry.color}</td>
                    <td>{entry.manufacturer}</td>
                    <td>{entry.type}</td>
                </tr>);
        });
        return (
            <table><tbody>{rows}</tbody></table>);
    }

    private clicked(entry: IPaintEntry) {
        this.setState({ selected: entry.id });
        if (this.props.selectedCallback) {
            this.props.selectedCallback(entry.id);
        }
    }

}
