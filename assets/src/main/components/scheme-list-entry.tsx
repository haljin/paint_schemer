import React from "react";
import { IScheme } from "../../data-types/response-types";

interface IProps {
    scheme: IScheme;
}
export default class SchemeListEntry extends React.Component<IProps> {
    public render() {
        const onSchemeViewClick = () => window.location.href = "/scheme/" + this.props.scheme.id;
        const onSchemeEditClick = () => window.location.href = "/scheme/edit/" + this.props.scheme.id;
        return (
            <div className="schemeEntry">
                <div onClick={onSchemeViewClick}>
                    {this.props.scheme.id} - {this.props.scheme.title}
                </div>
                <button type="button" onClick={onSchemeEditClick}>Edit</button>;
            </div >);
    }
}
