import React from "react";

interface IProps {
    children?: React.ReactNode;
    onClick: (e: React.FormEvent<HTMLButtonElement>) => void;
}

export default class DeleteButton extends React.Component<IProps, {}> {
    public render() {
        const onClick = (e: React.FormEvent<HTMLButtonElement>) => this.props.onClick(e);
        return <button className="deleteButton" type="button" onClick={onClick}> x</button >;
    }
}
