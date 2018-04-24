/* tslint:disable:object-literal-sort-keys interface-name*/
import { ActionCreator } from "redux";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";
import { IPaintMix, IPaintSection } from "./state";

export enum SchemeActionType {
    LOAD_SCHEME = "LOAD_SCHEME",
    VALIDATE_SCHEME = "VALIDATE_SCHEME",
    SAVE_SCHEME = "SAVE_SCHEME",
    UPDATE_TITLE = "UPDATE_TITLE",
    ADD_SECTION = "ADD_SECTION",
    UPDATE_SECTION = "UPDATE_SECTION",
    DELETE_SECTION = "DELETE_SECTION",
    ADD_STEP = "ADD_STEP",
    UPDATE_STEP = "UPDATE_STEP",
    MOVE_STEP = "MOVE_STEP",
    DELETE_STEP = "DELETE_STEP",
    UPDATE_PAINT_LIST = "UPDATE_PAINT_LIST",
    UPDATE_PAINT_TECHNIQUES = "UPDATE_PAINT_TECHNIQUES",
}

export interface LoadSchemeAction {
    readonly type: typeof SchemeActionType.LOAD_SCHEME;
    readonly paintSections: IPaintSection[];
    readonly title: string;
}

export interface ValidateSchemeAcion {
    readonly type: typeof SchemeActionType.VALIDATE_SCHEME;
}

export interface SaveSchemeAction {
    readonly type: typeof SchemeActionType.SAVE_SCHEME;
}

export interface UpdateTitleAction {
    readonly type: typeof SchemeActionType.UPDATE_TITLE;
}

export interface AddSectionAction {
    readonly type: typeof SchemeActionType.ADD_SECTION;
}

export interface UpdateSectionAction {
    readonly type: typeof SchemeActionType.UPDATE_SECTION;
    readonly sectionIndex: number;
    readonly name: string;
}

export interface DeleteSectionAction {
    readonly type: typeof SchemeActionType.DELETE_SECTION;
    readonly sectionIndex: number;
}

export interface AddStepAction {
    readonly type: typeof SchemeActionType.ADD_STEP;
    readonly sectionIndex: number;
}

export interface UpdateStepAction {
    readonly type: typeof SchemeActionType.UPDATE_STEP;
    readonly sectionIndex: number;
    readonly index: number;
    readonly paints?: IPaintMix[];
    readonly technique?: IPaintTechniqueEntry;
}
export interface MoveStepAction {
    readonly type: typeof SchemeActionType.MOVE_STEP;
    readonly sectionIndex: number;
    readonly index: number;
    readonly newIndex: number;
}

export interface DeleteStepAction {
    readonly type: typeof SchemeActionType.DELETE_STEP;
    readonly sectionIndex: number;
    readonly index: number;
}

export interface UpdatePaintListAction {
    readonly type: typeof SchemeActionType.UPDATE_PAINT_LIST;
    readonly paints: IPaintEntry[];
}

export interface UpdatePaintTechniquesAction {
    readonly type: typeof SchemeActionType.UPDATE_PAINT_TECHNIQUES;
    readonly techniques: IPaintTechniqueEntry[];
}

export const loadScheme: ActionCreator<LoadSchemeAction> =
    (scheme: IPaintSection[], title: string) => {
        return {
            type: SchemeActionType.LOAD_SCHEME,
            paintSections: scheme,
            title,
        };
    };

export const validateScheme: ActionCreator<ValidateSchemeAcion> =
    () => {
        return {
            type: SchemeActionType.VALIDATE_SCHEME,
        };
    };

export const saveScheme: ActionCreator<SaveSchemeAction> =
    () => {
        return {
            type: SchemeActionType.SAVE_SCHEME,
        };
    };

export const updateTitle: ActionCreator<UpdateTitleAction> =
    (title: string) => {
        return {
            type: SchemeActionType.UPDATE_TITLE,
            title,
        };
    };

export const addSection: ActionCreator<AddSectionAction> =
    () => {
        return {
            type: SchemeActionType.ADD_SECTION,
        };
    };

export const updateSection: ActionCreator<UpdateSectionAction> =
    (sectionIndex: number, name: string) => {
        return {
            type: SchemeActionType.UPDATE_SECTION,
            sectionIndex,
            name,
        };
    };

export const deleteSection: ActionCreator<DeleteSectionAction> =
    (sectionIndex: number) => {
        return {
            type: SchemeActionType.DELETE_SECTION,
            sectionIndex,
        };
    };

export const addStep: ActionCreator<AddStepAction> =
    (sectionIndex: number) => {
        return {
            type: SchemeActionType.ADD_STEP,
            sectionIndex,
        };
    };

export const updateStep: ActionCreator<UpdateStepAction> =
    (sectionIndex: number, index: number, paints?: IPaintMix[], technique?: IPaintTechniqueEntry) => {
        return {
            type: SchemeActionType.UPDATE_STEP,
            sectionIndex,
            index,
            paints,
            technique,
        };
    };

export const moveStep: ActionCreator<MoveStepAction> =
    (sectionIndex: number, index: number, newIndex: number) => {
        return {
            type: SchemeActionType.MOVE_STEP,
            sectionIndex,
            index,
            newIndex,
        };
    };

export const deleteStep: ActionCreator<DeleteStepAction> =
    (sectionIndex: number, index: number) => {
        return {
            type: SchemeActionType.DELETE_STEP,
            sectionIndex,
            index,
        };
    };

export const updatePaints: ActionCreator<UpdatePaintListAction> =
    (paints: IPaintEntry[]) => {
        return {
            type: SchemeActionType.UPDATE_PAINT_LIST,
            paints,
        };
    };

export const updateTechniques: ActionCreator<UpdatePaintTechniquesAction> =
    (techniques: IPaintTechniqueEntry[]) => {
        return {
            type: SchemeActionType.UPDATE_PAINT_TECHNIQUES,
            techniques,
        };
    };

export interface OtherAction { type: ""; }
export const otherAction: OtherAction = { type: "" };

export type SchemeAction =
    LoadSchemeAction |
    ValidateSchemeAcion |
    SaveSchemeAction |
    UpdateTitleAction |
    UpdatePaintListAction |
    UpdatePaintTechniquesAction |
    AddSectionAction |
    UpdateSectionAction |
    DeleteSectionAction |
    AddStepAction |
    UpdateStepAction |
    DeleteStepAction |
    MoveStepAction |
    OtherAction;
