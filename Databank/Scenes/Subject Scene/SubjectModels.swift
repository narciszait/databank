//
//  SubjectModels.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

enum Subject {
    enum Action {
        case itemSelected(row: Int)
    }
    
    enum Route {
        case showTable(subject: SubjectModel)
        case showGraph(tableID: String, subjectID: String, variables: [String])
    }
    
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Subject.Request {
    struct Subjects { }
}

extension Subject.Response {
    struct Subjects {
        let result: [SubjectModel]
    }
    
    struct Error {
        let message: String
    }
}

extension Subject.DisplayData {
    struct Subjects { }
    
    struct Error {
        let message: String
    }
}
