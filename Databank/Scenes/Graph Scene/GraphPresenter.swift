//
//  GraphPresenter.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class GraphPresenter {
    let interactor: GraphInteractorInput
    weak var coordinator: SubjectCoordinator?
    weak var output: GraphPresenterOutput?
    
    let tableID: String
    let subjectID: String
    let variables: [String]

    init(interactor: GraphInteractorInput, coordinator: SubjectCoordinator, tableID: String, subjectID: String, variables: [String]) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.tableID = tableID
        self.subjectID = subjectID
        self.variables = variables
    }
}

// MARK: - User Events -

extension GraphPresenter: GraphPresenterInput {
    func viewCreated() {
        interactor.perform(Graph.Request.Graph(tableID: tableID, subjectID: subjectID, variables: variables))
    }
    
    var navTitle: String {
        return tableID
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension GraphPresenter: GraphInteractorOutput {
    func present(_ response: Graph.Response.Graph) {
        output?.display(Graph.DisplayData.Graph(graphURL: response.graphURL))
    }
    
    func present(_ response: Graph.Response.Error) {
        output?.display(Graph.DisplayData.Error(message: response.message))
    }
    

}
