//
//  SubjectCoordinator.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import Foundation
import UIKit

class SubjectCoordinator: Coordinator {
    let navigationController: UINavigationController
    var children: [Coordinator] = []
    var repository: APIClient
    
    init(navigationController: UINavigationController, repository: APIClient) {
        self.navigationController = navigationController
        self.repository = repository
    }
    
    func start() {
        let interactor = SubjectInteractor(repository: repository)
        let presenter = SubjectPresenter(interactor: interactor, coordinator: self)
        let vc = SubjectViewController.instantiate(with: presenter)
        
        interactor.output = presenter
        presenter.output = vc
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func presentTableScene(subject: SubjectModel) {        
        let interactor = TablesInteractor(repository: repository)
        let presenter = TablesPresenter(interactor: interactor, coordinator: self, subject: subject)
        let vc = TablesViewController.instantiate(with: presenter)
        
        interactor.output = presenter
        presenter.output = vc
        
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentGraph(tableID: String, subjectID: String, variables: [String]) {
        let interactor = GraphInteractor(repository: repository)
        let presenter = GraphPresenter(interactor: interactor, coordinator: self, tableID: tableID, subjectID: subjectID, variables: variables)
        let vc = GraphViewController.instantiate(with: presenter)
        
        interactor.output = presenter
        presenter.output = vc
        
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
}

// PRESENTER -> COORDINATOR
extension SubjectCoordinator: SubjectCoordinatorInput {
    func navigate(route: Subject.Route) {
        switch route {
        case .showTable(let subject):
            presentTableScene(subject: subject)
        case .showGraph(let tableID, let subjectID, let variables):
            presentGraph(tableID: tableID, subjectID: subjectID, variables: variables)
        }
    }
    
    
}
