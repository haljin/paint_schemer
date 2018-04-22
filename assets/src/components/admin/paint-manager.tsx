import * as React from "react";
import { IPaintEntry } from "../../data-types/response-types";
import DataManager from "../common/data-manager";
import EntryDeleteButton from "../common/entry-delete-button";
import DataEntryForm from "../common/entry-form";
import PaintList from "./paint-list";

interface IProps {
    url: string;
    label?: string;
    selectedManufacturer?: number;
    selectedType?: number;
}
interface IState {
    selectedId?: number;
    color: string;
    data: IPaintEntry[];
}
export default class PaintManager extends DataManager<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { data: [], color: "#" };
    }

    public render() {
        const rfshCallback = () => this.refresh();
        const selectCallback = (id: number) => this.entrySelected(id);
        const onChangeCallback = (e: React.FormEvent<HTMLInputElement>) => this.onChange(e);
        const extraData = {
            color: this.state.color,
            manufacturer_id: this.props.selectedManufacturer,
            type_id: this.props.selectedType,
        };
        return (
            <div>
                {this.props.label}
                <PaintList list={this.state.data} selectedCallback={selectCallback} />
                <input type="text" value={this.state.color} onChange={onChangeCallback} />
                <DataEntryForm
                    extraData={extraData}
                    url={this.props.url}
                    refreshCallback={rfshCallback}
                />
                <EntryDeleteButton
                    url={this.props.url}
                    selectedId={this.state.selectedId}
                    refreshCallback={rfshCallback}
                />
            </div >);
    }

    private onChange(event: React.FormEvent<HTMLInputElement>) {
        const color = event.currentTarget.value;
        if (color.length > 7 || color.length < 1) {
            return;
        }
        if (color.length > 1 && !isHexCharacter(color.slice(-1))) {
            return;
        }
        this.setState({ color });
    }

}

function isHexCharacter(character: string) {
    return character >= "0" && character <= "9" ||
        character >= "A" && character <= "F" ||
        character >= "a" && character <= "f";
}
