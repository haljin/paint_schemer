import React from "react";
import Highlighter from "react-highlight-words";
import { connect, Dispatch } from "react-redux";
import Select, { Option, Options } from "react-select";
import { IPaintEntry } from "../../data-types/response-types";
import { updateStep, UpdateStepAction } from "../actions";
import { IPaintMix, ISchemeState } from "../state";

interface IProps {
  index: number;
  sectionIndex: number;
  paintList: IPaintEntry[];
  selectedValue: IPaintMix[];
  updatePaints: (sectionIndex: number, index: number, paints: IPaintMix[]) => UpdateStepAction;
}
export class Paint extends React.Component<IProps, {}> {
  private inputValue: string = "";
  public render() {
    const onInputChange = (inputValue: string) => this.inputValue = inputValue;
    return (
      <Select
        onInputChange={onInputChange}
        options={
          (this.props.selectedValue.length >= 3) ?
            this.props.selectedValue :
            this.props.paintList.map(this.makeOption)}
        multi={true}
        onChange={this.onChangeHandler}
        optionRenderer={this.renderOption}
        value={this.props.selectedValue.map(this.makeValue)}
        valueRenderer={this.renderValue(this.props.selectedValue)}
      />
    );
  }

  private makeOption(paint: IPaintEntry) {
    return { value: paint, label: paint.manufacturer + " " + paint.name };
  }

  private makeValue(step: IPaintMix) {
    return { value: step.paint, label: step.paint.manufacturer + " " + step.paint.name };
  }

  private onChangeHandler = (newValue: Option<IPaintEntry> | Options<IPaintEntry> | null) => {
    if ((newValue instanceof Array) && (newValue.length <= 3)) {
      const paints = newValue
        .filter((option) => option.value !== undefined)
        .map((option) => ({ paint: option.value, ratio: 1 })) as IPaintMix[];
      this.props.updatePaints(this.props.sectionIndex, this.props.index, paints);
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

  private renderValue = (mixes: IPaintMix[]) => (option: Option<IPaintEntry>) => {
    const onInputChange = (e: React.FormEvent<HTMLInputElement>) => {
      if (+e.currentTarget.value < 1) { e.currentTarget.value = "1"; }
      if (option.value) { this.updateRatio(option.value.id, +e.currentTarget.value); }
    };

    if (!option.value) {
      return null;
    }
    const selectedValue = mixes.filter((mix) => !!option.value && mix.paint.id === option.value.id);
    return (
      <div style={{ background: option.value.color }} >
        {option.value.name}
        {(this.props.selectedValue.length > 1) ?
          <input
            onChange={onInputChange}
            type="number"
            defaultValue={selectedValue[0].ratio.toString()}
          /> : null}
      </div>);
  }

  private updateRatio = (id: number, ratio: number) => {
    const values = this.props.selectedValue;
    values.map((mix: IPaintMix) => (mix.paint.id === id) ? mix.ratio = ratio : mix);
    this.props.updatePaints(this.props.sectionIndex, this.props.index, values);
  }
}

const mapStateToProps = (state: ISchemeState) => {
  return {
    paintList: state.paintList,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    updatePaints: (sectionIndex: number, index: number, paints: IPaintMix[]) =>
      dispatch(updateStep(sectionIndex, index, paints)),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedPaint = connect(mapStateToProps, mapDispatchToProps)(Paint);

export default ConnectedPaint;
