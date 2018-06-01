import React from "react";
import { IScheme } from "../../data-types/response-types";
import Scheme from "./scheme";
import SchemeList from "./scheme-list";

interface IState {
    selectedScheme: IScheme | null;
}
export default class MainView extends React.Component<any, IState> {
    constructor(props: any) {
        super(props);
        this.state = { selectedScheme: null };
    }

    public render() {
        const schemeId = (window as any).__SCHEME_ID__;
        if (!schemeId) {
            return <SchemeList />;
        }
        return <Scheme schemeId={schemeId} />;
    }

}
