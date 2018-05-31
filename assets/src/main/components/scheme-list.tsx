import React from "react";

interface IScheme {
    id: number;
    title: string;
}
interface ISchemeList {
    data: IScheme[];
}

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

        fetch("/api/schemes?page=" + this.state.cursor)
            .then((resp) => resp.json())
            .then((json) => this.setState({ cursor: this.state.cursor, data: json }));

    }

    public render() {
        const onClick = () => this.nextPage();
        const onClickPrev = () => this.prevPage();
        if (!this.state.data) {
            return <button className="addButton" type="button" onClick={onClick}> +</button >;
        }

        const schemes = this.state.data.data.map((scheme) => <div key={scheme.id}>{scheme.id} - {scheme.title}</div>);

        return (
            <div>
                {schemes}
                <button className="addButton" type="button" onClick={onClick}> +</button >
                {this.state.cursor > 1 &&
                    <button className="addButton" type="button" onClick={onClickPrev}> -</button >}
            </div>);
    }

    private nextPage() {
        fetch("/api/schemes?page=" + (this.state.cursor + 1))
            .then((resp) => resp.json())
            .then((json) => this.setState({ cursor: this.state.cursor + 1, data: json }));

    }

    private prevPage() {
        fetch("/api/schemes?page=" + (this.state.cursor - 1))
            .then((resp) => resp.json())
            .then((json) => this.setState({ cursor: this.state.cursor - 1, data: json }));

    }
}
