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
  sectionId: number;
  title: string;
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  paintSteps: IPaintStep[];
  onAddStep: (sectionId: number) => AddStepAction;
  onDeleteStep: (sectionId: number, i: number) => DeleteStepAction;
  onMoveStep: (sectionId: number, oldI: number, newI: number) => MoveStepAction;
  onUpdateTitle: (sectionId: number, title: string) => UpdateSectionAction;
}

class Section extends React.Component<IProps, {}> {
  public render() {
    const addHandler = () => this.props.onAddStep(this.props.sectionId);
    const updateTitleHandler = ({ title }: { title: string }) => this.props.onUpdateTitle(this.props.sectionId, title);

    return (
      <div className="schemeSection">
        <RIEInput
          value={this.props.title}
          change={updateTitleHandler}
          propName="title"
        />
        {this.renderPaints()}
        <AddButton onClick={addHandler} />
      </div>);
  }

  private renderPaints() {
    const { sectionId } = this.props;
    return this.props.paintSteps.map((paintStep, i) => {
      const moveUpHandler = () => this.props.onMoveStep(sectionId, i, i - 1);
      const moveDownHandler = () => this.props.onMoveStep(sectionId, i, i + 1);
      const deleteHandler = () => this.props.onDeleteStep(sectionId, i);
      return (
        <div key={i}>
          <Step
            sectionId={this.props.sectionId}
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
    onAddStep: (sectionId: number) => dispatch(addStep(sectionId)),
    onDeleteStep: (sectionId: number, index: number) => dispatch(deleteStep(sectionId, index)),
    onMoveStep: (sectionId: number, index: number, newIndex: number) => dispatch(moveStep(sectionId, index, newIndex)),
    onUpdateTitle: (sectionId: number, title: string) => dispatch(updateSection(sectionId, title)),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedSection = connect(() => ({}), mapDispatchToProps)(Section);

export default ConnectedSection;
