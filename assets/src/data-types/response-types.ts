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
}
