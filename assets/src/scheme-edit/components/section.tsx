import React from "react";
import { connect, Dispatch } from "react-redux";
import AddButton from "../../common/components/add-button";
import DeleteButton from "../../common/components/delete-button";
import DownButton from "../../common/components/down-button";
import UpButton from "../../common/components/up-button";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import { addStep, AddStepAction, deleteStep, DeleteStepAction } from "../actions";
import { IPaintSection, ISchemeState } from "../state";
import Paint from "./paint";
import PaintTechnique from "./technique";

interface IProps {
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  steps: IPaintSection;
  onAddStep: () => AddStepAction;
  onDeleteStep: (i: number) => DeleteStepAction;
}

interface IPaintsStep {
  paints: IPaintEntry[];
  technique: IPaintTechniqueEntry;
}

interface IState {
  paintSteps: IPaintsStep[];
}

class Section extends React.Component<IProps, IState> {
  private maxPaints: number = 10;

  constructor(props: IProps) {
    super(props);
    this.state = { paintSteps: [{ paints: [], technique: this.props.techniqueList[0] }] };
  }

  public render() {
    return (
      <div className="schemeSection">
        {this.renderPaints()}
        {this.state.paintSteps.length <= this.maxPaints && <AddButton onClick={this.props.onAddStep} />}
      </div>);
  }

  private renderPaints() {
    return this.props.steps.map((paintStep, i) => {
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

const mapStateToProps = (state: ISchemeState) => {
  return {
    steps: state.paintSteps,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onAddStep: () => dispatch(addStep()),
    onDeleteStep: (index: number) => dispatch(deleteStep(index)),
  };
};

const ConnectedSection = connect(mapStateToProps, mapDispatchToProps)(Section);

export default ConnectedSection;
