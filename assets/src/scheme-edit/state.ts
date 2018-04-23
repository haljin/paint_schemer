import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { SchemeAction, SchemeActionType } from "./actions";

interface IPaintsStep {
    paints: IPaintEntry[];
    technique: IPaintTechniqueEntry;
}

export interface ISchemeState {
    paintList: IPaintEntry[];
    paintSteps: IPaintsStep[];
    techniqueList: IPaintTechniqueEntry[];
}

const initialState: ISchemeState = {
    paintList: [],
    paintSteps: [],
    techniqueList: [],
};

export default function reducer(state: ISchemeState = initialState, action: SchemeAction): ISchemeState {
    switch (action.type) {
        case SchemeActionType.UPDATE_PAINT_LIST:
            return { ...state, paintList: action.paints };
        case SchemeActionType.UPDATE_PAINT_TECHNIQUES:
            return { ...state, techniqueList: action.techniques };
        default:
            return state;
    }

}
