/* tslint:disable:object-literal-sort-keys interface-name*/
import { ActionCreator } from 'redux';
import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";

export enum SchemeActionType {
    UPDATE_STEP = "UPDATE_STEP",
    ADD_STEP = "ADD_STEP",
    DELETE_STEP = "DELETE_STEP",
    MOVE_STEP = "MOVE_STEP",
    UPDATE_PAINT_LIST = "UPDATE_PAINT_LIST",
    UPDATE_PAINT_TECHNIQUES = "UPDATE_PAINT_TECHNIQUES",
}

export interface UpdateStepAction {
    readonly type: typeof SchemeActionType.UPDATE_STEP;
    readonly sectionId: number;
    readonly index: number;
    readonly paints?: IPaintEntry[];
    readonly technique?: IPaintTechniqueEntry;
}

export interface AddStepAction {
    readonly type: typeof SchemeActionType.ADD_STEP;
    readonly sectionId: number;
}

export interface DeleteStepAction {
    readonly type: typeof SchemeActionType.DELETE_STEP;
    readonly sectionId: number;
    readonly index: number;
}

export interface MoveStepAction {
    readonly type: typeof SchemeActionType.MOVE_STEP;
    readonly sectionId: number;
    readonly index: number;
    readonly newIndex: number;
}

export interface UpdatePaintListAction {
    readonly type: typeof SchemeActionType.UPDATE_PAINT_LIST;
    readonly paints: IPaintEntry[];
}

export interface UpdatePaintTechniquesAction {
    readonly type: typeof SchemeActionType.UPDATE_PAINT_TECHNIQUES;
    readonly techniques: IPaintTechniqueEntry[];
}

export const updateStep: ActionCreator<UpdateStepAction> =
    (sectionId: number, index: number, paints?: IPaintEntry[], technique?: IPaintTechniqueEntry) => {
        return {
            type: SchemeActionType.UPDATE_STEP,
            sectionId,
            index,
            paints,
            technique,
        };
    }

export const addStep: ActionCreator<AddStepAction> =
    (sectionId: number) => {
        return {
            type: SchemeActionType.ADD_STEP,
            sectionId,
        };
    }

export const deleteStep: ActionCreator<DeleteStepAction> =
    (sectionId: number, index: number) => {
        return {
            type: SchemeActionType.DELETE_STEP,
            sectionId,
            index,
        };
    }

export const moveStep: ActionCreator<MoveStepAction> =
    (sectionId: number, index: number, newIndex: number) => {
        return {
            type: SchemeActionType.MOVE_STEP,
            sectionId,
            index,
            newIndex,
        };
    }

export const updatePaints: ActionCreator<UpdatePaintListAction> =
    (paints: IPaintEntry[]) => {
        return {
            type: SchemeActionType.UPDATE_PAINT_LIST,
            paints,
        };
    }

export const updateTechniques: ActionCreator<UpdatePaintTechniquesAction> =
    (techniques: IPaintTechniqueEntry[]) => {
        return {
            type: SchemeActionType.UPDATE_PAINT_TECHNIQUES,
            techniques,
        };
    }

export type SchemeAction =
    UpdatePaintListAction |
    UpdatePaintTechniquesAction |
    AddStepAction |
    UpdateStepAction |
    DeleteStepAction |
    MoveStepAction;
