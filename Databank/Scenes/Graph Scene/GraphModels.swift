//
//  GraphModels.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

enum Graph {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Graph.Request {
    struct Graph {
        let tableID: String
        let subjectID: String
        let variables: [String]
    }
}

extension Graph.Response {
    struct Graph {
        let graphURL: URL
    }
    
    struct Error {
        let message: String
    }
}

extension Graph.DisplayData {
    struct Graph {
        let graphURL: URL
    }
    
    struct Error {
        let message: String
    }
}
