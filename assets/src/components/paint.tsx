import * as React from "react";
import { Option } from "react-select";
import Select from "react-select";
import { IPaintEntry } from "../data-types/response-types";

interface IProps {
  children?: React.ReactNode;
  paintList: IPaintEntry[];
}
export default class Paint extends React.Component<IProps, { value?: any }> {
  constructor(props: IProps) {
    super(props);
    this.state = {};
  }

  public render() {
    const onChange = (d: any) => this.setState({ value: d });
    return (
      <Select
        options={this.props.paintList.map((paint) => ({ value: paint, label: paint.name }))}
        multi={true}
        onChange={onChange}
        value={this.state.value}
        valueRenderer={this.renderOption}
      />
    );
  }

  private renderOption(option: Option<IPaintEntry>) {
    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.color }}>
        {option.value.name}
        <input type="text" />
      </div>);
  }
}
