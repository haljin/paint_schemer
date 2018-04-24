import React from "react";
import { connect, Dispatch } from "react-redux";
import { RIEInput } from "rieke";
import AddButton from "../../common/components/add-button";
import DeleteButton from "../../common/components/delete-button";
import DownButton from "../../common/components/down-button";
import UpButton from "../../common/components/up-button";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import {
  addStep, AddStepAction, deleteStep, DeleteStepAction,
  moveStep, MoveStepAction, updateSection, UpdateSectionAction,
} from "../actions";
import { IPaintStep, ISchemeState } from "../state";
import Step from "./step";

interface IProps {
  sectionIndex: number;
  name: string;
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  paintSteps: IPaintStep[];
  onAddStep: (sectionIndex: number) => AddStepAction;
  onDeleteStep: (sectionIndex: number, i: number) => DeleteStepAction;
  onMoveStep: (sectionIndex: number, oldI: number, newI: number) => MoveStepAction;
  onUpdateTitle: (sectionIndex: number, title: string) => UpdateSectionAction;
}

class Section extends React.Component<IProps, {}> {
  public render() {
    const addHandler = () => this.props.onAddStep(this.props.sectionIndex);
    const updateTitleHandler = ({ title }: { title: string }) =>
      this.props.onUpdateTitle(this.props.sectionIndex, title);

    return (
      <div className="schemeSection">
        <RIEInput
          value={this.props.name}
          change={updateTitleHandler}
          propName="title"
        />
        {this.renderPaints()}
        <AddButton onClick={addHandler} />
      </div>);
  }

  private renderPaints() {
    const { sectionIndex } = this.props;
    return this.props.paintSteps.map((paintStep, i) => {
      const moveUpHandler = () => this.props.onMoveStep(sectionIndex, i, i - 1);
      const moveDownHandler = () => this.props.onMoveStep(sectionIndex, i, i + 1);
      const deleteHandler = () => this.props.onDeleteStep(sectionIndex, i);
      return (
        <div key={i}>
          <Step
            sectionIndex={this.props.sectionIndex}
            stepId={i}
            paints={paintStep.paints}
            technique={paintStep.technique}
            valid={paintStep.valid}
          />
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

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onAddStep: (sectionIndex: number) => dispatch(addStep(sectionIndex)),
    onDeleteStep: (sectionIndex: number, index: number) => dispatch(deleteStep(sectionIndex, index)),
    onMoveStep: (sectionIndex: number, index: number, newIndex: number) =>
      dispatch(moveStep(sectionIndex, index, newIndex)),
    onUpdateTitle: (sectionIndex: number, title: string) => dispatch(updateSection(sectionIndex, title)),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedSection = connect(() => ({}), mapDispatchToProps)(Section);

export default ConnectedSection;
