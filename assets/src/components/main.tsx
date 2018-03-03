import * as React from "react";
import { IPaintEntry } from "../data-types/response-types";
import Paint from "./paint";
export default class MainComponent extends React.Component<{ children?: React.ReactNode }, { data: IPaintEntry[] }> {
  constructor(props: any) {
    super(props);
    this.state = { data: [] };
  }

  public componentDidMount() {
    this.refresh();
  }

  public render() {
    return (
      <div>
        <Paint paintList={this.state.data} />
      </div>);
  }

  protected refresh() {
    this.getRequest("/api/paints")
      .then((data) => this.setState({ data }));
  }

  private getRequest(url: string) {
    return fetch(url)
      .then((resp) => resp.json())
      .then((json) => json.data);
  }

}
