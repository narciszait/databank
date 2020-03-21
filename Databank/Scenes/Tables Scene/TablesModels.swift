//
//  TablesModels.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

enum Tables {
    enum Action {
        case itemSelected(row: Int)
    }
    
    enum Route {
        case showGraph(tableID: String)
    }
    
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Tables.Request {
    struct Tables {
        let subjectID: String
    }
}

extension Tables.Response {
    struct Tables {
        let result: [TableModel]
    }
    
    struct Error {
        let message: String
    }
}

extension Tables.DisplayData {
    struct Tables { }
    
    struct Error {
        let message: String
    }
}
