import * as React from "react";
import { IPaintEntry } from "../../data-types/response-types";

interface IProps {
    list: IPaintEntry[];
    children?: React.ReactNode;
}

export default class ExtendedEntryList extends React.Component<IProps, {}> {

    public render() {
        const rows = this.props.list.map((entry, i) => (
            <tr key={i}>
                <td>{entry.name}</td>
                <td>{entry.color}</td>
                <td>{entry.manufacturer}</td>
                <td>{entry.type}</td>
            </tr>));
        return (
            <table><tbody>{rows}</tbody></table>);
    }
}
