import React from "react";
import Highlighter from "react-highlight-words";
import { connect, Dispatch } from "react-redux";
import Select, { Option, Options } from "react-select";
import { IPaintEntry } from "../../data-types/response-types";
import { updateStep, UpdateStepAction } from "../actions";
import { ISchemeState } from "../state";

interface IProps {
  index: number;
  sectionId: number;
  paintList: IPaintEntry[];
  selectedValue: IPaintEntry[];
  updatePaints: (sectionId: number, index: number, paints: IPaintEntry[]) => UpdateStepAction;
}
export class Paint extends React.Component<IProps, {}> {
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
      this.props.updatePaints(this.props.sectionId, this.props.index, paints);
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
      if (option.value) { this.updateRatio(option.value.id, +e.currentTarget.value); }
    };

    if (!option.value) {
      return null;
    }
    return (
      <div style={{ background: option.value.color }} >
        {option.value.name}
        {(this.props.selectedValue.length > 1) ?
          <input
            onChange={onInputChange}
            type="number"
            defaultValue={option.value.ratio ? option.value.ratio.toString() : "1"}
          /> : null}
      </div>);
  }

  private updateRatio = (id: number, ratio: number) => {
    const values = this.props.selectedValue;
    values.map((paint: IPaintEntry) => (paint.id === id) ? paint.ratio = ratio : paint);
    this.props.updatePaints(this.props.sectionId, this.props.index, values);
  }
}

const mapStateToProps = (state: ISchemeState) => {
  return {
    paintList: state.paintList,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    updatePaints: (sectionId: number, index: number, paints: IPaintEntry[]) => dispatch(updateStep(sectionId, index, paints)),
  };
};

const ConnectedPaint = connect(mapStateToProps, mapDispatchToProps)(Paint);

export default ConnectedPaint;
