import React from "react";
import { connect, Dispatch } from "react-redux";
import AddButton from "../../common/components/add-button";
import DeleteButton from "../../common/components/delete-button";
import DownButton from "../../common/components/down-button";
import UpButton from "../../common/components/up-button";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import { addStep, AddStepAction, deleteStep, DeleteStepAction, moveStep, MoveStepAction } from "../actions";
import { IPaintSection, ISchemeState } from "../state";
import Paint from "./paint";
import PaintTechnique from "./technique";

interface IProps {
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  paintSteps: IPaintSection;
  onAddStep: () => AddStepAction;
  onDeleteStep: (i: number) => DeleteStepAction;
  onMoveStep: (oldI: number, newI: number) => MoveStepAction;
}

class Section extends React.Component<IProps, {}> {
  constructor(props: IProps) {
    super(props);
    this.state = { paintSteps: [{ paints: [], technique: this.props.techniqueList[0] }] };
  }

  public render() {
    return (
      <div className="schemeSection">
        {this.renderPaints()}
        <AddButton onClick={this.props.onAddStep} />
      </div>);
  }

  private renderPaints() {
    return this.props.paintSteps.map((paintStep, i) => {
      const moveUpHandler = () => this.props.onMoveStep(i, i - 1);
      const moveDownHandler = () => this.props.onMoveStep(i, i + 1);
      const deleteHandler = () => this.props.onDeleteStep(i);
      return (
        <div key={i}>
          <Paint
            index={i}
            selectedValue={paintStep.paints}
          />
          {this.props.techniqueList.length > 0 && <PaintTechnique
            index={i}
            selectedValue={paintStep.technique}
          />}
          {this.props.paintSteps.length > 1 &&
            <div>
              {i > 0 && <UpButton onClick={moveUpHandler} />}
              {i < this.props.paintSteps.length - 1 &&
                <DownButton onClick={moveDownHandler} />}
              <DeleteButton onClick={deleteHandler} />
            </div>}
        </div>
      );
    });
  }
}

const mapStateToProps = (state: ISchemeState) => {
  return {
    paintSteps: state.paintSteps,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onAddStep: () => dispatch(addStep()),
    onDeleteStep: (index: number) => dispatch(deleteStep(index)),
    onMoveStep: (index: number, newIndex: number) => dispatch(moveStep(index, newIndex)),
  };
};

const ConnectedSection = connect(mapStateToProps, mapDispatchToProps)(Section);

export default ConnectedSection;
