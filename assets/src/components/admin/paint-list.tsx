import * as React from "react";
import { IPaintEntry } from "../../data-types/response-types";
import EntryList from "../common/list";

interface IProps {
    list: IPaintEntry[];
    selectedCallback?: (id: number) => void;
    children?: React.ReactNode;
}

interface IState {
    selected: number | null;
}

export default class PaintList extends EntryList<IProps, IState> {
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
            <table>
                <thead><td>Name</td><td>Color</td><td>Manufacturer</td><td>Type</td></thead>
                <tbody>{rows}</tbody>
            </table>);
    }

}
