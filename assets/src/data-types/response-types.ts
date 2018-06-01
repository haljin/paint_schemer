export interface IDataEntry {
    id: number;
    name: string;
}

export interface IManfacturerEntry extends IDataEntry { }

export interface ITypeEntry extends IDataEntry { }

export interface IPaintEntry extends IDataEntry {
    manufacturer?: string;
    type?: string;
    color: string;
    ratio?: number;
}

export interface IPaintTechniqueEntry extends IDataEntry { }

export interface IScheme {
    id: number;
    title: string;
}
export interface ISchemeList {
    data: IScheme[];
}
