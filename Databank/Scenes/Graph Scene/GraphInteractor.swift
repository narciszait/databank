//
//  GraphInteractor.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class GraphInteractor {
    weak var output: GraphInteractorOutput?
    let repository: APIClient
    
    init(repository: APIClient) {
        self.repository = repository
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension GraphInteractor: GraphInteractorInput {
    func perform(_ request: Graph.Request.Graph) {
        repository.fetchGraph(request.tableID, request.subjectID, request.variables) { result in
            switch result {
            case .success(let data):
                self.output?.present(Graph.Response.Graph(graphURL: data))
            case .failure(let error):
                self.output?.present(Graph.Response.Error(message: error.localizedDescription))
            }
        }
    }    
}
