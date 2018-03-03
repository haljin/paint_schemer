import * as React from "react";
import Highlighter from "react-highlight-words";
import { Option, Options } from "react-select";
import Select from "react-select";
import { IPaintEntry } from "../data-types/response-types";

interface IProps {
  children?: React.ReactNode;
  paintList: IPaintEntry[];
}
export default class Paint extends React.Component<IProps, { selectedValue: Options<IPaintEntry> }> {
  private inputValue: string = "";

  constructor(props: IProps) {
    super(props);
    this.state = { selectedValue: [] };
  }

  public render() {
    const onChange = this.onChangeHandler.bind(this);
    const onInputChange = (inputValue: string) => this.inputValue = inputValue;
    const optionRenderFun = this.renderOption.bind(this);
    const valueRenderFun = this.renderValue.bind(this);
    return (
      <Select
        onInputChange={onInputChange}
        options={this.props.paintList.map((paint) => ({ value: paint, label: paint.manufacturer + " " + paint.name }))}
        multi={true}
        onChange={onChange}
        optionRenderer={optionRenderFun}
        value={this.state.selectedValue}
        valueRenderer={valueRenderFun}
      />
    );
  }

  private onChangeHandler(newValue: Option<IPaintEntry> | Options<IPaintEntry> | null) {
    if (newValue instanceof Array) {
      this.setState({ selectedValue: newValue });
    }
  }

  private renderOption(option: Option<IPaintEntry>) {
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

  private renderValue(option: Option<IPaintEntry>) {
    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.color }}>
        {option.value.name}
        {(this.state.selectedValue.length > 1) ? <input type="number" defaultValue="1" /> : null}
      </div>);
  }
}
