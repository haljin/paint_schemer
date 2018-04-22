import React from "react";
import Highlighter from "react-highlight-words";
import { Option, Options } from "react-select";
import Select from "react-select";
import { IPaintEntry } from "../data-types/response-types";

interface IProps {
  children?: React.ReactNode;
  paintList: IPaintEntry[];
  selectedValue: IPaintEntry[];
  updatePaints: (paints: IPaintEntry[]) => void;
}
export default class Paint extends React.Component<IProps, {}> {
  private inputValue: string = "";
  public render() {
    const onInputChange = (inputValue: string) => this.inputValue = inputValue;
    return (
      <Select
        onInputChange={onInputChange}
        options={this.props.paintList.map(this.makeOption)}
        multi={true}
        onChange={this.onChangeHandler}
        optionRenderer={this.renderOption}
        value={this.props.selectedValue.map(this.makeOption)}
        valueRenderer={this.renderValue}
      />
    );
  }

  private makeOption(paint: IPaintEntry) {
    return { value: paint, label: paint.manufacturer + " " + paint.name };
  }

  private onChangeHandler = (newValue: Option<IPaintEntry> | Options<IPaintEntry> | null) => {
    if (newValue instanceof Array) {
      const paints = newValue
        .filter((option) => option.value !== undefined)
        .map((option) => option.value) as IPaintEntry[];
      this.props.updatePaints(paints);
    }
  }

  private renderOption = (option: Option<IPaintEntry>) => {
    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.color }}>
        <Highlighter
          searchWords={[this.inputValue]}
          textToHighlight={option.label ? option.label : ""}
        />
      </div>);
  }

  private renderValue = (option: Option<IPaintEntry>) => {
    const onInputChange = (e: React.FormEvent<HTMLInputElement>) => {
      if (+e.currentTarget.value < 1) { e.currentTarget.value = "1"; }
    };

    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.color }} >
        {option.value.name}
        {(this.props.selectedValue.length > 1) ?
          <input onChange={onInputChange} type="number" defaultValue="1" /> : null}
      </div>);
  }
}
