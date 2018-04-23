import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { SchemeActionType } from "./actions";
import { Reducer } from "redux";

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

const reducer: Reducer<ISchemeState> = (state: ISchemeState = initialState, action) => {
    switch (action.type) {
        case SchemeActionType.UPDATE_PAINT_LIST:
            return { ...state, paintList: action.paints };
        case SchemeActionType.UPDATE_PAINT_TECHNIQUES:
            const initialStep = [{ paints: [], technique: action.techniques[0] }];
            return { ...state, paintSteps: initialStep, techniqueList: action.techniques };
        case SchemeActionType.ADD_STEP:
            if (state.techniqueList.length > 1) {
                const newStep = { paints: [], technique: state.techniqueList[0] };
                return { ...state, paintSteps: [...state.paintSteps, newStep] };
            }
            return state;
        case SchemeActionType.DELETE_STEP:
            const deletedSteps = state.paintSteps.filter((_paint, i) => i !== action.index);
            return { ...state, paintSteps: deletedSteps };
        case SchemeActionType.MOVE_STEP:
            const movedSteps = [...state.paintSteps];
            const moved = movedSteps.splice(action.index, 1);
            movedSteps.splice(action.newIndex, 0, moved[0]);
            return { ...state, paintSteps: movedSteps };
        case SchemeActionType.UPDATE_STEP:
            const newSteps =
                state.paintSteps.map((step, i) => {
                    if (i === action.index) {
                        const newPaints = (action.paints) ? action.paints : step.paints;
                        const newTechnique = (action.technique) ? action.technique : step.technique;
                        return { ...step, paints: newPaints, technique: newTechnique }
                    }
                    return step;
                })
            return { ...state, paintSteps: newSteps };
        default:
            return state;
    }
}

export default reducer;
