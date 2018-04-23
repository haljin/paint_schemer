import React from "react";
import Highlighter from "react-highlight-words";
import { connect, Dispatch } from "react-redux";
import { Option } from "react-select";
import Select from "react-select";
import { IPaintTechniqueEntry } from "../../data-types/response-types";
import { updateStep, UpdateStepAction } from "../actions";
import { ISchemeState } from "../state";

interface IProps {
  index: number;
  sectionId: number;
  techniqueList: IPaintTechniqueEntry[];
  selectedValue: IPaintTechniqueEntry;
  updateTechnique: (sectionId: number, index: number, paints: IPaintTechniqueEntry) => UpdateStepAction;
}

export class PaintTechnique extends React.Component<IProps, {}> {
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
      this.props.updateTechnique(this.props.sectionId, this.props.index, newValue.value);
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

const mapStateToProps = (state: ISchemeState) => {
  return {
    techniqueList: state.techniqueList,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    updateTechnique: (sectionId: number, index: number, technique: IPaintTechniqueEntry) =>
      dispatch(updateStep(sectionId, index, undefined, technique)),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedPaintTechnique = connect(mapStateToProps, mapDispatchToProps)(PaintTechnique);

export default ConnectedPaintTechnique;
