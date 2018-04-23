import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { SchemeAction, SchemeActionType } from "./actions";

interface IPaintStep {
    paints: IPaintEntry[];
    technique: IPaintTechniqueEntry;
}

export type IPaintSection = IPaintStep[];

export interface ISchemeState {
    paintList: IPaintEntry[];
    paintSteps: IPaintStep[];
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
            const initialStep = [{ paints: [], technique: action.techniques[0] }];
            return { ...state, paintSteps: initialStep, techniqueList: action.techniques };
        case SchemeActionType.ADD_STEP:
            if (state.techniqueList.length > 1) {
                const newStep = { paints: [], technique: state.techniqueList[0] };
                const newSteps = [...state.paintSteps, newStep];
                return { ...state, paintSteps: newSteps };
            }
            return state;
        case SchemeActionType.DELETE_STEP:
            const paintSteps = [...state.paintSteps];
            paintSteps.splice(action.index, 1);
            return { ...state, paintSteps };
        default:
            return state;
    }

}
