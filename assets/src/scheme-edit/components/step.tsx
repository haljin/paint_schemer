import React from "react";
import { IPaintTechniqueEntry } from "../../data-types/response-types";
import { IPaintMix } from "../state";
import Paint from "./paint";
import PaintTechnique from "./technique";

interface IProps {
  sectionIndex: number;
  stepId: number;
  paints: IPaintMix[];
  technique: IPaintTechniqueEntry;
  valid?: boolean;
}

export default class Step extends React.Component<IProps, {}> {
  public render() {
    const classNames = ["paintStep"];
    if (this.props.valid === false) {
      classNames.push("invalid");
    }
    return (
      <div className={classNames.join(" ")}>
        <Paint
          sectionIndex={this.props.sectionIndex}
          index={this.props.stepId}
          selectedValue={this.props.paints}
        />
        <PaintTechnique
          sectionIndex={this.props.sectionIndex}
          index={this.props.stepId}
          selectedValue={this.props.technique}
        />
      </div>);
  }
}
