//
//  TablesProtocols.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation
import UIKit


// PRESENTER -> COORDINATOR
protocol TablesCoordinatorInput: AnyObject {
    
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol TablesInteractorInput {
    func perform(_ request: Tables.Request.Tables)
}

// INTERACTOR -> PRESENTER (indirect)
protocol TablesInteractorOutput: AnyObject {
    func present(_ response: Tables.Response.Tables)
    func present(_ response: Tables.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol TablesPresenterInput {
    func viewCreated()
    func handle(action: Tables.Action)
    
    var numberOfItems: Int { get }
    var navTitle: String { get }
    func configure(item: TablesCellCustomasiableProtocol, at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol TablesPresenterOutput: AnyObject {
    func display(_ displayModel: Tables.DisplayData.Tables)
    func display(_ error: Tables.DisplayData.Error)
}
