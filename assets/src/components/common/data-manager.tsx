import * as React from "react";
import { IDataEntry } from "../../data-types/response-types";

interface IProps {
    url: string;
    type: string;
    dataCallback?(data: IDataEntry[]): void;
    children?: React.ReactNode;
}

interface IState {
    content: string;
    list: IDataEntry[];
    result: string;
}
export default class DataManager extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { content: "", result: "", list: [] };
    }

    public componentDidMount() {
        this.getRequest();
    }

    public render() {
        const onSubmitCallback = (e: React.FormEvent<HTMLFormElement>) => this.onSubmit(e);
        const onChangeCallback = (e: React.FormEvent<HTMLInputElement>) => this.onChange(e);
        return (
            <div>
                {this.props.children}
                <form onSubmit={onSubmitCallback}>
                    <input type="text" value={this.state.content} onChange={onChangeCallback} />
                    <input type="submit" value="Create" />
                </form>
                <div>{this.state.result}</div>
            </div>
        );
    }

    private onSubmit(event: React.FormEvent<HTMLFormElement>) {
        event.preventDefault();
        this.postRequest();
        this.setState({ content: "" });
    }

    private onChange(event: React.FormEvent<HTMLInputElement>) {
        this.setState({ content: event.currentTarget.value });
    }

    private getRequest() {
        fetch(this.props.url)
            .then((resp) => resp.json())
            .then((json) => {
                this.setState({ list: json.data });
                if (this.props.dataCallback) {
                    this.props.dataCallback(json.data);
                }
            });
    }

    private postRequest() {
        const data = { [this.props.type]: { name: this.state.content } };
        const request = {
            body: JSON.stringify(data),
            headers: {
                "Content-type": "application/json",
            },
            method: "POST",
        };

        fetch(this.props.url, request)
            .then(() => this.setState({ result: "Success" }))
            .then(() => this.getRequest())
            .catch((error) => this.setState({ result: `Failed ${error}` }));
    }

}
