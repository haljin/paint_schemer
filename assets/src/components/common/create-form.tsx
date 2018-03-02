import * as React from "react";
import {IDataEntry} from "../../data-types/response-types";
import {EntryList} from "./list";

interface IProps {
    url: string;
    type: string;
}

interface IState {
    content: string;
    list: IDataEntry[];
    result: string;
}
export default class CreateForm extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { content: "", result: "", list: []};
    }

    public componentDidMount() {
        this.getRequest();
    }

    public render() {
        const onSubmitCallback = (e) => this.onSubmit(e);
        const onChangeCallback = (e) => this.onChange(e);
        return (
            <div>
                <EntryList list={this.state.list}/>
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
            .then((json) => this.setState({ list: json.data}));
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
