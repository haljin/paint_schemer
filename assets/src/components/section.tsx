import React from "react";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import AddButton from "./common/add-button";
import DeleteButton from "./common/delete-button";
import DownButton from "./common/down-button";
import UpButton from "./common/up-button";
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
    const addPaint = () => this.addStep();
    return (
      <div className="schemeSection">
        {this.renderPaints()}
        {this.state.paintSteps.length <= this.maxPaints && <AddButton onClick={addPaint} />}
      </div>);
  }

  private renderPaints() {
    return this.state.paintSteps.map((paintStep, i) => {
      return (
        <div key={i}>
          <Paint
            selectedValue={paintStep.paints}
            paintList={this.props.paintList}
            updatePaints={this.updateStep(i)}
          />
          {this.props.techniqueList.length > 0 && <PaintTechnique
            selectedValue={paintStep.technique}
            techniqueList={this.props.techniqueList}
            updateTechnique={this.updateTechnique(i)}
          />}
          {this.state.paintSteps.length > 1 &&
            <div>
              {i > 0 && <UpButton onClick={this.moveStep(i, i - 1)} />}
              {i < this.state.paintSteps.length - 1 &&
                <DownButton onClick={this.moveStep(i, i + 1)} />}
              <DeleteButton onClick={this.deleteStep(i)} />
            </div>}
        </div>
      );
    });
  }

  private addStep() {
    if (this.state.paintSteps.length > this.maxPaints) {
      return;
    }
    const newPaints = this.state.paintSteps;
    newPaints.push({ paints: [], technique: this.props.techniqueList[0] });
    this.setState({ paintSteps: newPaints });
  }

  private updateStep = (index: number) => {
    return (paints: IPaintEntry[]) => {
      const newPaints = this.state.paintSteps;
      newPaints[index].paints = paints;
      this.setState({ paintSteps: newPaints });
    };
  }

  private deleteStep = (index: number) => {
    return () => {
      const newPaints = this.state.paintSteps;
      newPaints.splice(index, 1);
      this.setState({ paintSteps: newPaints });
    };
  }

  private updateTechnique = (index: number) => {
    return (technique: IPaintTechniqueEntry) => {
      const newPaints = this.state.paintSteps;
      newPaints[index].technique = technique;
      this.setState({ paintSteps: newPaints });
    };
  }

  private moveStep = (index: number, newIndex: number) => {
    return () => {
      const newPaints = this.state.paintSteps;
      const moved = newPaints.splice(index, 1);
      newPaints.splice(newIndex, 0, moved[0]);
      this.setState({ paintSteps: newPaints });
    };
  }
}
