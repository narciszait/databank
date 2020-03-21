//
//  SubjectInteractor.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class SubjectInteractor {
    weak var output: SubjectInteractorOutput?
    let repository: APIClient
    
    init(repository: APIClient) {
        self.repository = repository
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension SubjectInteractor: SubjectInteractorInput {
    func perform(_ request: Subject.Request.Subjects) {
        repository.fetchSubjects { result in
            switch result {
            case .success(let data):
                self.output?.present(Subject.Response.Subjects(result: data))
            case .failure(let error):
                self.output?.present(Subject.Response.Error(message: error.localizedDescription))
            }
        }
    }
    
    
}
