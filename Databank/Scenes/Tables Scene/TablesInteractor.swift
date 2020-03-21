//
//  TablesInteractor.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class TablesInteractor {
    weak var output: TablesInteractorOutput?
    
    let repository: APIClient
    
    init(repository: APIClient) {
        self.repository = repository
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension TablesInteractor: TablesInteractorInput {
    func perform(_ request: Tables.Request.Tables) {
        repository.fetchTables(request.subjectID) { result in
            switch result {
            case .success(let data):
                self.output?.present(Tables.Response.Tables(result: data))
            case .failure(let error):
                self.output?.present(Tables.Response.Error(message: error.localizedDescription))
            }
        }
    }
    
}
