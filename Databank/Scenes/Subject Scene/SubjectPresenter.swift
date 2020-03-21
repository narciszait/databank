//
//  SubjectPresenter.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class SubjectPresenter {
    let interactor: SubjectInteractorInput
    weak var coordinator: SubjectCoordinatorInput?
    weak var output: SubjectPresenterOutput?
    
    var subjects: [SubjectModel] = []

    init(interactor: SubjectInteractorInput, coordinator: SubjectCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension SubjectPresenter: SubjectPresenterInput {
    func viewCreated() {
        interactor.perform(Subject.Request.Subjects())
    }
    
    var numberOfItems: Int {
        return subjects.count
    }
    
    func configure(item: SubjectCellCustomisableProtocol, at indexPath: IndexPath) {
        let subjectItem = subjects[indexPath.row]
        
        guard let title = subjectItem.subjectDescription else {
            output?.display(Subject.DisplayData.Error(message: "There has been an error"))
            return }
        item.configure(title: title)
    }
    
    func handle(action: Subject.Action) {
        switch action {
        case .itemSelected(let row):
            let subjectItem = subjects[row]
            coordinator?.navigate(route: .showTable(subject: subjectItem))
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension SubjectPresenter: SubjectInteractorOutput {
    func present(_ response: Subject.Response.Subjects) {
        self.subjects = response.result
        output?.display(Subject.DisplayData.Subjects())
    }
    
    func present(_ response: Subject.Response.Error) {
        output?.display(Subject.DisplayData.Error(message: response.message))
    }
    

}
