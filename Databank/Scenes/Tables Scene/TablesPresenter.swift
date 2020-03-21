//
//  TablesPresenter.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation

class TablesPresenter {
    let interactor: TablesInteractorInput
    weak var coordinator: SubjectCoordinator?
    weak var output: TablesPresenterOutput?
    var subject: SubjectModel
    
    var tables = [TableModel]()

    init(interactor: TablesInteractorInput, coordinator: SubjectCoordinator, subject: SubjectModel) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.subject = subject
    }
}

// MARK: - User Events -

extension TablesPresenter: TablesPresenterInput {
    func viewCreated() {
        guard let subjectID = subject.id else {
            output?.display(Tables.DisplayData.Error(message: "There has been an error"))
            return
        }
        interactor.perform(Tables.Request.Tables(subjectID: subjectID))
    }
    
    var numberOfItems: Int {
        return tables.count
    }
    
    var navTitle: String {
        return subject.subjectDescription ?? ""
    }
    
    func configure(item: TablesCellCustomasiableProtocol, at indexPath: IndexPath) {
        let tableItem = tables[indexPath.row]
        
        guard let title = tableItem.text,
            let firstPeriod = tableItem.firstPeriod,
            let latestPeriod = tableItem.latestPeriod,
            let tableID = tableItem.id
            else {
                output?.display(Tables.DisplayData.Error(message: "There has been an error"))
                return
        }
        
        item.configure(title: title, firstPeriod: firstPeriod, latestPeriod: latestPeriod, tableID: tableID)
    }
    
    func handle(action: Tables.Action) {
        switch action {
        case .itemSelected(let row):
            let table = tables[row]
            guard let tableID = table.id,
                let subjectID = subject.id,
                let variables = table.variables else {
                output?.display(Tables.DisplayData.Error(message: "There has been an error"))
                return
            }
            coordinator?.navigate(route: .showGraph(tableID: tableID, subjectID: subjectID, variables: variables))
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension TablesPresenter: TablesInteractorOutput {
    func present(_ response: Tables.Response.Tables) {
        self.tables = response.result
        output?.display(Tables.DisplayData.Tables())
    }
    
    func present(_ response: Tables.Response.Error) {
        output?.display(Tables.DisplayData.Error(message: response.message))
    }
    

}
