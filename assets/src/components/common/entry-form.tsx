import React from "react";

interface IProps {
    children?: React.ReactNode;
    url: string;
    extraData?: object;
    refreshCallback: () => void;
}

interface IState {
    content: string;
    result: string;
}
export default class DataEntryForm extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = { content: "", result: "" };
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

    private postRequest() {
        const { extraData = {} } = this.props;
        const data = { data: { name: this.state.content, ...extraData } };
        const request = {
            body: JSON.stringify(data),
            headers: {
                "Content-type": "application/json",
            },
            method: "POST",
        };

        fetch(this.props.url, request)
            .then((resp) => {
                if (resp.status === 201) {
                    return this.setState({ result: "Success" });
                }
                throw new Error(`${resp.status} - ${resp.statusText}`);
            })
            .then(() => this.props.refreshCallback())
            .catch((error) => this.setState({ result: `Failed ${error}` }));
    }

}
