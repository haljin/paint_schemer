import React from "react";
import { connect, Dispatch } from "react-redux";
import AddButton from "../../common/components/add-button";
import DeleteButton from "../../common/components/delete-button";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import {
  addSection, AddSectionAction, deleteSection, DeleteSectionAction,
  UpdatePaintListAction, updatePaints, UpdatePaintTechniquesAction, updateTechniques,
} from "../actions";
import { IPaintSection, ISchemeState } from "../state";
import Section from "./section";

interface IProps {
  paintList: IPaintEntry[];
  paintSections: IPaintSection[];
  techniqueList: IPaintTechniqueEntry[];
  onPaintListUpdate: (paints: IPaintEntry[]) => UpdatePaintListAction;
  onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => UpdatePaintTechniquesAction;
  onAddSection: () => AddSectionAction;
  onDeleteSection: (sectionId: number) => DeleteSectionAction;
}

export class MainComponent extends React.Component<IProps> {
  public componentDidMount() {
    this.refresh();
  }

  public render() {
    return (
      <div>
        {this.props.paintSections.map((section, i) => {
          const deleteHandler = () => this.props.onDeleteSection(i);
          return (
            <div key={i}>
              <Section
                sectionId={i}
                title={section.title}
                paintSteps={section.steps}
                paintList={this.props.paintList}
                techniqueList={this.props.techniqueList}
              />
              {this.props.paintSections.length > 1 &&
                <div>
                  <DeleteButton onClick={deleteHandler} />
                </div>}
            </div>);
        })}
        <AddButton onClick={this.props.onAddSection} />
      </div>);
  }

  protected refresh() {
    this.getRequest("/api/paints")
      .then((data) => this.props.onPaintListUpdate(data));
    this.getRequest("/api/paint_techniques")
      .then((data) => this.props.onTechniqueListUpdate(data));
  }

  private getRequest(url: string) {
    return fetch(url)
      .then((resp) => resp.json())
      .then((json) => json.data);
  }
}

const mapStateToProps = (state: ISchemeState) => {
  return {
    paintList: state.paintList,
    paintSections: state.paintSections,
    techniqueList: state.techniqueList,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onAddSection: () => dispatch(addSection()),
    onDeleteSection: (sectionId: number) => dispatch(deleteSection(sectionId)),
    onPaintListUpdate: (paints: IPaintEntry[]) => dispatch(updatePaints(paints)),
    onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => dispatch(updateTechniques(techniques)),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedMainComponent = connect(mapStateToProps, mapDispatchToProps)(MainComponent);

export default ConnectedMainComponent;
