import React from "react";
import Highlighter from "react-highlight-words";
import { Option } from "react-select";
import Select from "react-select";
import { IPaintTechniqueEntry } from "../data-types/response-types";

interface IProps {
  children?: React.ReactNode;
  techniqueList: IPaintTechniqueEntry[];
  selectedValue: IPaintTechniqueEntry;
  updateTechnique: (paints: IPaintTechniqueEntry) => void;
}

export default class PaintTechnique extends React.Component<IProps, {}> {
  private inputValue: string = "";
  public render() {
    const onChange = this.onChangeHandler.bind(this);
    const optionRenderFun = this.renderOption.bind(this);
    const onInputChange = (inputValue: string) => this.inputValue = inputValue;
    return (
      <Select
        onInputChange={onInputChange}
        options={this.props.techniqueList.map(this.makeOption)}
        onChange={onChange}
        value={this.makeOption(this.props.selectedValue)}
        optionRenderer={optionRenderFun}
        clearable={false}
      />
    );
  }

  private makeOption(technique: IPaintTechniqueEntry) {
    return { value: technique, label: technique.name };
  }

  private onChangeHandler(newValue: Option<IPaintTechniqueEntry>) {
    if (newValue.value) {
      this.props.updateTechnique(newValue.value);
    }
  }

  private renderOption(option: Option<IPaintTechniqueEntry>) {
    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.name }}>
        <Highlighter
          searchWords={[this.inputValue]}
          textToHighlight={option.label ? option.label : ""}
        />
      </div>);
  }

}
