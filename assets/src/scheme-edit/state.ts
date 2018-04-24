import { Reducer } from "redux";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { SchemeAction, SchemeActionType } from "./actions";

export interface IPaintStep {
    paints: IPaintEntry[];
    technique: IPaintTechniqueEntry;
    valid?: boolean;
}

export interface IPaintSection {
    name: string;
    steps: IPaintStep[];
}

export interface ISchemeState {
    paintList: IPaintEntry[];
    paintSections: IPaintSection[];
    techniqueList: IPaintTechniqueEntry[];
    title: string;
}

export const initialState: ISchemeState = {
    paintList: [],
    paintSections: [],
    techniqueList: [],
    title: "Unnamed Scheme",
};

function isValid(paintSections: IPaintSection[]): boolean {
    return paintSections.every((section) =>
        section.steps.every((step) => !!step.valid));
}

const reducer: Reducer<ISchemeState> = (state = initialState, action: SchemeAction): ISchemeState => {
    switch (action.type) {
        case SchemeActionType.LOAD_SCHEME:
            return { ...state, paintSections: action.paintSections, title: action.title };
        case SchemeActionType.VALIDATE_SCHEME:
            const validatedSections = state.paintSections.map((section): IPaintSection => {
                const validatedSteps = section.steps.map((step): IPaintStep => {
                    return { ...step, valid: step.paints.length > 0 };
                });
                return { ...section, steps: validatedSteps };
            });
            return { ...state, paintSections: validatedSections };
        case SchemeActionType.SAVE_SCHEME:
            if (isValid(state.paintSections)) {
                const data = { scheme: { title: state.title, sections: state.paintSections } };
                const request = {
                    body: JSON.stringify(data),
                    headers: {
                        "Content-type": "application/json",
                    },
                    method: "POST",
                };
                fetch("/api/schemes", request)
                    .then((resp) => console.log(resp)); // tslint:disable-line:no-console
            }
            return state;
        case SchemeActionType.UPDATE_PAINT_LIST:
            return { ...state, paintList: action.paints };
        case SchemeActionType.UPDATE_PAINT_TECHNIQUES:
            const initialStep = [{ paints: [], technique: action.techniques[0] }];
            const initialSection = [{ name: "Unnamed Section", steps: initialStep }];
            return {
                ...state,
                paintSections: (state.paintSections.length > 0) ? state.paintSections : initialSection,
                techniqueList: action.techniques,
            };
        case SchemeActionType.ADD_SECTION:
            const newStep = [{ paints: [], technique: state.techniqueList[0] }];
            const newSection = { name: "Unnamed Section", steps: newStep };
            return { ...state, paintSections: [...state.paintSections, newSection] };
        case SchemeActionType.UPDATE_SECTION:
            const updatedSections = state.paintSections.map((section, i): IPaintSection => {
                if (i === action.sectionIndex) {
                    return { ...section, name: action.name };
                }
                return section;
            });
            return { ...state, paintSections: updatedSections };
        case SchemeActionType.DELETE_SECTION:
            const deletedSections = state.paintSections.filter((_paint, i) => i !== action.sectionIndex);
            return { ...state, paintSections: deletedSections };
        case SchemeActionType.ADD_STEP:
            if (state.techniqueList.length > 1) {
                const newSections =
                    state.paintSections.map((section, i): IPaintSection => {
                        if (action.sectionIndex === i) {
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
                state.paintSections.map((section, i): IPaintSection => {
                    if (action.sectionIndex === i) {
                        const deletedSteps = section.steps.filter((_paint, j) => j !== action.index);
                        return { ...section, steps: deletedSteps };
                    }
                    return section;
                });
            return { ...state, paintSections: deletedSectionSteps };
        case SchemeActionType.MOVE_STEP:
            const movedSectionSteps =
                state.paintSections.map((section, i): IPaintSection => {
                    if (action.sectionIndex === i) {
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
                state.paintSections.map((section, i): IPaintSection => {
                    if (action.sectionIndex === i) {
                        const updatedSteps =
                            section.steps.map((step, j): IPaintStep => {
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
