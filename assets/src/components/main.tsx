import React from "react";
import { connect, Dispatch } from "react-redux";
import { ISchemeState } from "state";
import { updatePaints, updateTechniques } from "../actions";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import Section from "./section";

interface IProps {
  children?: React.ReactNode;
  paintList: IPaintEntry[];
  techniqueList: IPaintTechniqueEntry[];
  onPaintListUpdate: (paints: IPaintEntry[]) => any;
  onTechniqueListUpdate: (techniques: IPaintTechniqueEntry[]) => any;
}

export class MainComponent extends React.Component<IProps> {
  public componentDidMount() {
    this.refresh();
  }

  public render() {
    return (
      <div>
        {this.props.techniqueList.length > 0 &&
          <Section paintList={this.props.paintList} techniqueList={this.props.techniqueList} />}
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
