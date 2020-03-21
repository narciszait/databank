//
//  AppCoordinator.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {

    let window: UIWindow
    var children: [Coordinator] = []
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showMain()
        
        window.makeKeyAndVisible()
    }
    
    func showMain() {
        let repository = APIClient()
        
        let subjectCoordinator = SubjectCoordinator(navigationController: .init(), repository: repository)
        children += [subjectCoordinator]
        window.rootViewController = subjectCoordinator.navigationController
        
        subjectCoordinator.start()
    }
}
