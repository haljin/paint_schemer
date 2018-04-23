import React from "react";
import Highlighter from "react-highlight-words";
import { Option } from "react-select";
import Select from "react-select";
import { IPaintTechniqueEntry } from "../../data-types/response-types";

interface IProps {
  children?: React.ReactNode;
  techniqueList: IPaintTechniqueEntry[];
  selectedValue: IPaintTechniqueEntry;
  updateTechnique: (paints: IPaintTechniqueEntry) => void;
}

export default class PaintTechnique extends React.Component<IProps, {}> {
  private inputValue: string = "";
  public render() {
    const onInputChange = (inputValue: string) => this.inputValue = inputValue;
    return (
      <Select
        onInputChange={onInputChange}
        options={this.props.techniqueList.map(this.makeOption)}
        onChange={this.onChangeHandler}
        value={this.makeOption(this.props.selectedValue)}
        optionRenderer={this.renderOption}
        clearable={false}
      />
    );
  }

  private makeOption(technique: IPaintTechniqueEntry) {
    return { value: technique, label: technique.name };
  }

  private onChangeHandler = (newValue: Option<IPaintTechniqueEntry> | null) => {
    if (newValue && newValue.value) {
      this.props.updateTechnique(newValue.value);
    }
  }

  private renderOption = (option: Option<IPaintTechniqueEntry>) => {
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
