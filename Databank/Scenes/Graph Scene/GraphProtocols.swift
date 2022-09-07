//
//  GraphProtocols.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation
import UIKit

// PRESENTER -> COORDINATOR
protocol GraphCoordinatorInput: AnyObject {

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol GraphInteractorInput {
    func perform(_ request: Graph.Request.Graph)
}

// INTERACTOR -> PRESENTER (indirect)
protocol GraphInteractorOutput: AnyObject {
    func present(_ response: Graph.Response.Graph)
    func present(_ response: Graph.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol GraphPresenterInput {
    func viewCreated()
    
    var navTitle: String { get }
}

// PRESENTER -> VIEW
protocol GraphPresenterOutput: AnyObject {
    func display(_ displayModel: Graph.DisplayData.Graph)
    func display(_ error: Graph.DisplayData.Error)
}
