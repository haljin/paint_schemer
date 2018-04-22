import React from "react";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import AddButton from "./common/add-button";
import DeleteButton from "./common/delete-button";
import Paint from "./paint";
import PaintTechnique from "./technique";

interface IProps {
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
}

interface IPaintsStep {
  paints: IPaintEntry[];
  technique: IPaintTechniqueEntry;
}

interface IState {
  paintSteps: IPaintsStep[];
}

export default class Section extends React.Component<IProps, IState> {
  private maxPaints: number = 10;

  constructor(props: IProps) {
    super(props);
    this.state = { paintSteps: [{ paints: [], technique: this.props.techniqueList[0] }] };
  }

  public render() {
    const addPaint = () => this.addPaints();
    return (
      <div className="schemeSection">
        {this.renderPaints()}
        {this.state.paintSteps.length <= this.maxPaints && <AddButton onClick={addPaint} />}
      </div>);
  }

  private renderPaints() {
    return this.state.paintSteps.map((paintStep, i) => {
      const updatePaints = this.updatePaint(i).bind(this);
      const deletePaints = this.deletePaint(i).bind(this);
      const updateTechnique = this.updateTechnique(i).bind(this);
      return (
        <div key={i}>
          <Paint
            key={"paint_" + i}
            selectedValue={paintStep.paints}
            paintList={this.props.paintList}
            updatePaints={updatePaints}
          />
          {this.props.techniqueList.length > 0 && <PaintTechnique
            key={"technique_" + i}
            selectedValue={paintStep.technique}
            techniqueList={this.props.techniqueList}
            updateTechnique={updateTechnique}
          />}
          {this.state.paintSteps.length > 1 && <DeleteButton key={"button_" + i} onClick={deletePaints} />}
        </div>
      );
    });
  }

  private addPaints() {
    if (this.state.paintSteps.length > this.maxPaints) {
      return;
    }
    const newPaints = this.state.paintSteps;
    newPaints.push({ paints: [], technique: this.props.techniqueList[0] });
    this.setState({ paintSteps: newPaints });
  }

  private updatePaint(index: number) {
    return (paints: IPaintEntry[]) => {
      const newPaints = this.state.paintSteps;
      newPaints[index].paints = paints;
      this.setState({ paintSteps: newPaints });
    };
  }

  private deletePaint(index: number) {
    return () => {
      const newPaints = this.state.paintSteps;
      newPaints.splice(index, 1);
      this.setState({ paintSteps: newPaints });
    };
  }

  private updateTechnique(index: number) {
    return (technique: IPaintTechniqueEntry) => {
      const newPaints = this.state.paintSteps;
      newPaints[index].technique = technique;
      this.setState({ paintSteps: newPaints });
    };
  }
}
