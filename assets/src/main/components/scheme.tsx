import React from "react";
import { IScheme } from "../../data-types/response-types";

interface IProps {
  schemeId: number;
}

interface IState {
  scheme: IScheme | null;
}

export default class Scheme extends React.Component<IProps, IState> {
  constructor(props: IProps) {
    super(props);
    this.state = { scheme: null };
  }
  public componentDidMount() {
    fetch("/api/schemes/" + this.props.schemeId)
      .then((resp) => resp.json())
      .then((json) => this.setState({ scheme: json.data }));
  }

  public render() {

    if (!this.state.scheme) {
      return <div>Loading...</div>;
    }
    return (
      <div>
        {JSON.stringify(this.state.scheme)}
      </div>);
  }

}
