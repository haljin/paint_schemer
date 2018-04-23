import { IPaintEntry, IPaintTechniqueEntry } from "../data-types/response-types";

/* tslint:disable:object-literal-sort-keys interface-name*/
export enum SchemeActionType {
    CHANGE_RATIO = "CHANGE_RATIO",
    UPDATE_STEP = "UPDATE_STEP",
    ADD_STEP = "ADD_STEP",
    DELETE_STEP = "DELETE_STEP",
    MOVE_STEP = "MOVE_STEP",
    UPDATE_PAINT_LIST = "UPDATE_PAINT_LIST",
    UPDATE_PAINT_TECHNIQUES = "UPDATE_PAINT_TECHNIQUES",
}

export interface ChangeRatioAction {
    readonly type: typeof SchemeActionType.CHANGE_RATIO;
    readonly paintId: number;
    readonly ratio: number;
}

export interface UpdateStepAction {
    readonly type: typeof SchemeActionType.UPDATE_STEP;
    readonly index: number;
    readonly paints: IPaintEntry[];
}

export interface AddStepAction {
    readonly type: typeof SchemeActionType.ADD_STEP;
}

export interface DeleteStepAction {
    readonly type: typeof SchemeActionType.DELETE_STEP;
    readonly index: number;
}

export interface MoveStepAction {
    readonly type: typeof SchemeActionType.MOVE_STEP;
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

export function changeRatio(paintId: number, ratio: number): ChangeRatioAction {
    return {
        type: SchemeActionType.CHANGE_RATIO,
        paintId,
        ratio,
    };
}

export function updateStep(index: number, paints: IPaintEntry[]): UpdateStepAction {
    return {
        type: SchemeActionType.UPDATE_STEP,
        index,
        paints,
    };
}

export function addStep(): AddStepAction {
    return {
        type: SchemeActionType.ADD_STEP,
    };
}

export function deleteStep(index: number): DeleteStepAction {
    return {
        type: SchemeActionType.DELETE_STEP,
        index,
    };
}

export function moveStep(index: number, newIndex: number): MoveStepAction {
    return {
        type: SchemeActionType.MOVE_STEP,
        index,
        newIndex,
    };
}

export function updatePaints(paints: IPaintEntry[]): UpdatePaintListAction {
    return {
        type: SchemeActionType.UPDATE_PAINT_LIST,
        paints,
    };
}

export function updateTechniques(techniques: IPaintTechniqueEntry[]): UpdatePaintTechniquesAction {
    return {
        type: SchemeActionType.UPDATE_PAINT_TECHNIQUES,
        techniques,
    };
}

export type SchemeAction =
    UpdatePaintListAction |
    UpdatePaintTechniquesAction |
    ChangeRatioAction |
    AddStepAction |
    UpdateStepAction |
    DeleteStepAction |
    MoveStepAction;
