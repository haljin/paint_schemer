import React from "react";
import { connect, Dispatch } from "react-redux";
import { IPaintEntry, IPaintTechniqueEntry } from "../../data-types/response-types";
import { UpdatePaintListAction, updatePaints, UpdatePaintTechniquesAction, updateTechniques } from "../actions";
import { ISchemeState } from "../state";
import Section from "./section";

interface IProps {
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  onPaintListUpdate: (paints: IPaintEntry[]) => UpdatePaintListAction;
  onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => UpdatePaintTechniquesAction;
}

export class MainComponent extends React.Component<IProps> {
  public componentDidMount() {
    this.refresh();
  }

  public render() {
    return (
      <div>
        {this.props.techniqueList.length > 0 &&
          <Section sectionId={1} paintList={this.props.paintList} techniqueList={this.props.techniqueList} />}
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
    techniqueList: state.techniqueList,
  };
};

const mapDispatchToProps = (dispatch: Dispatch<ISchemeState>) => {
  return {
    onPaintListUpdate: (paints: IPaintEntry[]) => dispatch(updatePaints(paints)),
    onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => dispatch(updateTechniques(techniques)),
  };
};

const ConnectedMainComponent = connect(mapStateToProps, mapDispatchToProps)(MainComponent);

export default ConnectedMainComponent;
