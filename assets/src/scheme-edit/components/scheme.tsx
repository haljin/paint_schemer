import React from "react";
import { connect, Dispatch } from "react-redux";
import { RIEInput } from "rieke";
import AddButton from "../../common/components/add-button";
import DeleteButton from "../../common/components/delete-button";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import {
  addSection, AddSectionAction, deleteSection, DeleteSectionAction,
  saveScheme, SaveSchemeAction, UpdatePaintListAction, updatePaints,
  UpdatePaintTechniquesAction, updateTechniques, updateTitle, UpdateTitleAction,
  validateScheme, ValidateSchemeAcion,
} from "../actions";
import { IPaintSection, ISchemeState } from "../state";
import SaveButton from "./save-button";
import Section from "./section";

interface IProps {
  paintList: IPaintEntry[];
  paintSections: IPaintSection[];
  techniqueList: IPaintTechniqueEntry[];
  title: string;
  onPaintListUpdate: (paints: IPaintEntry[]) => UpdatePaintListAction;
  onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => UpdatePaintTechniquesAction;
  onAddSection: () => AddSectionAction;
  onDeleteSection: (sectionIndex: number) => DeleteSectionAction;
  validate: () => ValidateSchemeAcion;
  onSave: () => SaveSchemeAction;
  onUpdateTitle: (title: string) => UpdateTitleAction;
}

class Scheme extends React.Component<IProps> {
  public componentDidMount() {
    this.refresh();
  }

  public render() {
    const updateTitleHandler = ({ title }: { title: string }) =>
      this.props.onUpdateTitle(title);
    return (
      <div>
        <RIEInput
          value={this.props.title}
          change={updateTitleHandler}
          propName="title"
        />
        {this.props.paintSections.map((section, i) => {
          const deleteHandler = () => this.props.onDeleteSection(i);
          return (
            <div key={i}>
              <Section
                sectionIndex={i}
                name={section.name}
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
        <SaveButton onClick={this.saveScheme} />
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

  private saveScheme = () => {
    this.props.validate();
    this.props.onSave();
  }
}

const mapStateToProps = (state: ISchemeState) => {
  return {
    paintList: state.paintList,
    paintSections: state.paintSections,
    techniqueList: state.techniqueList,
    title: state.title,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onAddSection: () => dispatch(addSection()),
    onDeleteSection: (sectionIndex: number) => dispatch(deleteSection(sectionIndex)),
    onPaintListUpdate: (paints: IPaintEntry[]) => dispatch(updatePaints(paints)),
    onSave: () => dispatch(saveScheme()),
    onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => dispatch(updateTechniques(techniques)),
    onUpdateTitle: (title: string) => dispatch(updateTitle(title)),
    validate: () => dispatch(validateScheme()),
  };
};

// tslint:disable-next-line:variable-name
const ConnectedScheme = connect(mapStateToProps, mapDispatchToProps)(Scheme);

export default ConnectedScheme;
