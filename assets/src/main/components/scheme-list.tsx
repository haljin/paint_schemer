import React from "react";
import { IScheme, ISchemeList } from "../../data-types/response-types";
import SchemeListEntry from "./scheme-list-entry";

interface IState {
    cursor: number;
    data?: ISchemeList;
}

export default class SchemeList extends React.Component<any, IState> {
    constructor(props: any) {
        super(props);
        this.state = { cursor: 1 };

    }

    public componentDidMount() {
        this.requestPage(1);
    }

    public render() {
        const onClickNext = () => this.requestPage(this.state.cursor + 1);
        const onClickPrev = () => this.requestPage(this.state.cursor - 1);
        if (!this.state.data) {
            return <button className="nextPage" type="button" onClick={onClickNext}> +</button >;
        }

        const schemes = this.state.data.data.map((scheme) =>
            <SchemeListEntry key={scheme.id} scheme={scheme} />);

        return (
            <div>
                {schemes}
                {schemes.length > 0 &&
                    <button className="nextPage" type="button" onClick={onClickNext}> +</button >}
                {this.state.cursor > 1 &&
                    <button className="prevPage" type="button" onClick={onClickPrev}> -</button >}
            </div>);
    }

    private requestPage(pageNo: number) {
        return fetch("/api/schemes?page=" + pageNo)
            .then((resp) => resp.json())
            .then((json) => this.setState({ cursor: pageNo, data: json }));
    }
}
