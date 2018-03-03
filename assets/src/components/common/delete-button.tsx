import * as React from "react";

interface IProps {
    children?: React.ReactNode;
    url: string;
    selectedId?: number;
    refreshCallback(): void;
}

export default class DeleteButton extends React.Component<IProps, {}> {
    public render() {
        const onClick = () => this.deleteRequest();
        return <button type="submit" onClick={onClick}> Delete</button >;
    }

    private deleteRequest() {
        if (this.props.selectedId) {
            const request = {
                headers: {
                    "Content-type": "application/json",
                },
                method: "DELETE",
            };

            fetch(this.props.url + "/" + this.props.selectedId, request)
                .then(() => this.props.refreshCallback());
        }
    }
}
