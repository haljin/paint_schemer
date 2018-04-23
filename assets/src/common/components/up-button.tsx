import React from "react";

interface IProps {
    children?: React.ReactNode;
    onClick: (e: React.FormEvent<HTMLButtonElement>) => void;
}

export default class UpButton extends React.Component<IProps, {}> {
    public render() {
        const onClick = (e: React.FormEvent<HTMLButtonElement>) => this.props.onClick(e);
        return <button className="upButton" type="button" onClick={onClick}> /\ </button >;
    }
}
