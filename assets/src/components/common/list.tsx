import * as React from "react";
import { IDataEntry } from "../../data-types/response-types";

interface IProps {
    list: IDataEntry[];
    children?: React.ReactNode;
}

export class EntryList extends React.Component<IProps, {}> {

    public render() {
        return (
            <ul>
                {this.props.list.map((entry, i) => <li key={i}>{entry.name}</li>)}
            </ul>);
    }

}
