import React from "react";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import Section from "./section";

interface IState {
  data: IPaintEntry[];
  techniques: IPaintTechniqueEntry[];
}
export default class MainComponent extends React.Component<{ children?: React.ReactNode }, IState> {
  constructor(props: any) {
    super(props);
    this.state = { data: [], techniques: [] };
  }

  public componentDidMount() {
    this.refresh();
  }

  public render() {
    return (
      <div>
        {this.state.techniques.length > 0 &&
          <Section paintList={this.state.data} techniqueList={this.state.techniques} />}
      </div>);
  }

  protected refresh() {
    this.getRequest("/api/paints")
      .then((data) => this.setState({ data }));
    this.getRequest("/api/paint_techniques")
      .then((data) => this.setState({ techniques: data }));
  }

  private getRequest(url: string) {
    return fetch(url)
      .then((resp) => resp.json())
      .then((json) => json.data);
  }

}
