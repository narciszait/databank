//
//  SubjectProtocols.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //


// PRESENTER -> COORDINATOR
protocol SubjectCoordinatorInput: class {
    func navigate(route: Subject.Route)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol SubjectInteractorInput {
    func perform(_ request: Subject.Request.Subjects)
}

// INTERACTOR -> PRESENTER (indirect)
protocol SubjectInteractorOutput: class {
    func present(_ response: Subject.Response.Subjects)
    func present(_ response: Subject.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol SubjectPresenterInput {
    func viewCreated()
    func handle(action: Subject.Action)
    
    var numberOfItems: Int { get }
    func configure(item: SubjectCellCustomisableProtocol, at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol SubjectPresenterOutput: class {
    func display(_ displayModel: Subject.DisplayData.Subjects)
    func display(_ error: Subject.DisplayData.Error)
}
