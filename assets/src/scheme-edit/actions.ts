/* tslint:disable:object-literal-sort-keys interface-name*/
import { ActionCreator } from "redux";
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";

export enum SchemeActionType {
    VALIDATE_SCHEME = "VALIDATE_SCHEME",
    SAVE_SCHEME = "SAVE_SCHEME",
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

export interface ValidateSchemeAcion {
    readonly type: typeof SchemeActionType.VALIDATE_SCHEME;
}

export interface SaveSchemeAction {
    readonly type: typeof SchemeActionType.SAVE_SCHEME;
}

export interface AddSectionAction {
    readonly type: typeof SchemeActionType.ADD_SECTION;
}

export interface UpdateSectionAction {
    readonly type: typeof SchemeActionType.UPDATE_SECTION;
    readonly sectionId: number;
    readonly name: string;
}

export interface DeleteSectionAction {
    readonly type: typeof SchemeActionType.DELETE_SECTION;
    readonly sectionId: number;
}

export interface AddStepAction {
    readonly type: typeof SchemeActionType.ADD_STEP;
    readonly sectionId: number;
}

export interface UpdateStepAction {
    readonly type: typeof SchemeActionType.UPDATE_STEP;
    readonly sectionId: number;
    readonly index: number;
    readonly paints?: IPaintEntry[];
    readonly technique?: IPaintTechniqueEntry;
}
export interface MoveStepAction {
    readonly type: typeof SchemeActionType.MOVE_STEP;
    readonly sectionId: number;
    readonly index: number;
    readonly newIndex: number;
}

export interface DeleteStepAction {
    readonly type: typeof SchemeActionType.DELETE_STEP;
    readonly sectionId: number;
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

export const addSection: ActionCreator<AddSectionAction> =
    () => {
        return {
            type: SchemeActionType.ADD_SECTION,
        };
    };

export const updateSection: ActionCreator<UpdateSectionAction> =
    (sectionId: number, name: string) => {
        return {
            type: SchemeActionType.UPDATE_SECTION,
            sectionId,
            name,
        };
    };

export const deleteSection: ActionCreator<DeleteSectionAction> =
    (sectionId: number) => {
        return {
            type: SchemeActionType.DELETE_SECTION,
            sectionId,
        };
    };

export const addStep: ActionCreator<AddStepAction> =
    (sectionId: number) => {
        return {
            type: SchemeActionType.ADD_STEP,
            sectionId,
        };
    };

export const updateStep: ActionCreator<UpdateStepAction> =
    (sectionId: number, index: number, paints?: IPaintEntry[], technique?: IPaintTechniqueEntry) => {
        return {
            type: SchemeActionType.UPDATE_STEP,
            sectionId,
            index,
            paints,
            technique,
        };
    };

export const moveStep: ActionCreator<MoveStepAction> =
    (sectionId: number, index: number, newIndex: number) => {
        return {
            type: SchemeActionType.MOVE_STEP,
            sectionId,
            index,
            newIndex,
        };
    };

export const deleteStep: ActionCreator<DeleteStepAction> =
    (sectionId: number, index: number) => {
        return {
            type: SchemeActionType.DELETE_STEP,
            sectionId,
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
    ValidateSchemeAcion |
    SaveSchemeAction |
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
