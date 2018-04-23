import { Reducer } from "redux";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { SchemeAction, SchemeActionType } from "./actions";

export interface IPaintStep {
    paints: IPaintEntry[];
    technique: IPaintTechniqueEntry;
}

export interface IPaintSection {
    title: string;
    steps: IPaintStep[];
}

export interface ISchemeState {
    paintList: IPaintEntry[];
    paintSections: IPaintSection[];
    techniqueList: IPaintTechniqueEntry[];
}

export const initialState: ISchemeState = {
    paintList: [],
    paintSections: [],
    techniqueList: [],
};

const reducer: Reducer<ISchemeState> = (state = initialState, action: SchemeAction) => {
    switch (action.type) {
        case SchemeActionType.UPDATE_PAINT_LIST:
            return { ...state, paintList: action.paints };
        case SchemeActionType.UPDATE_PAINT_TECHNIQUES:
            const initialStep = [{ paints: [], technique: action.techniques[0] }];
            const initialSection = [{ title: "Unnamed Section", steps: initialStep }];
            return {
                ...state,
                paintSections: initialSection,
                techniqueList: action.techniques,
            };
        case SchemeActionType.ADD_SECTION:
            const newStep = [{ paints: [], technique: state.techniqueList[0] }];
            const newSection = { title: "Unnamed Section", steps: newStep };
            return { ...state, paintSections: [...state.paintSections, newSection] };
        case SchemeActionType.DELETE_SECTION:
            const deletedSections = state.paintSections.filter((_paint, i) => i !== action.sectionId);
            return { ...state, paintSections: deletedSections };
        case SchemeActionType.ADD_STEP:
            if (state.techniqueList.length > 1) {
                const newSections =
                    state.paintSections.map((section, i) => {
                        if (action.sectionId === i) {
                            const newSectionStep = { paints: [], technique: state.techniqueList[0] };
                            return { ...section, steps: [...section.steps, newSectionStep] };
                        }
                        return section;
                    });
                return { ...state, paintSections: newSections };
            }
            return state;
        case SchemeActionType.DELETE_STEP:
            const deletedSectionSteps =
                state.paintSections.map((section, i) => {
                    if (action.sectionId === i) {
                        const deletedSteps = section.steps.filter((_paint, j) => j !== action.index);
                        return { ...section, steps: deletedSteps };
                    }
                    return section;
                });
            return { ...state, paintSections: deletedSectionSteps };
        case SchemeActionType.MOVE_STEP:
            const movedSectionSteps =
                state.paintSections.map((section, i) => {
                    if (action.sectionId === i) {
                        const movedSteps = [...section.steps];
                        const moved = movedSteps.splice(action.index, 1);
                        movedSteps.splice(action.newIndex, 0, moved[0]);
                        return { ...section, steps: movedSteps };
                    }
                    return section;
                });
            return { ...state, paintSections: movedSectionSteps };
        case SchemeActionType.UPDATE_STEP:
            const updatedSectionSteps =
                state.paintSections.map((section, i) => {
                    if (action.sectionId === i) {
                        const updatedSteps =
                            section.steps.map((step, j) => {
                                if (j === action.index) {
                                    const newPaints = (action.paints) ? action.paints : step.paints;
                                    const newTechnique = (action.technique) ? action.technique : step.technique;
                                    return { ...step, paints: newPaints, technique: newTechnique };
                                }
                                return step;
                            });
                        return { ...section, steps: updatedSteps };
                    }
                    return section;
                });
            return { ...state, paintSections: updatedSectionSteps };
        default:
            return state;
    }
};

export default reducer;
