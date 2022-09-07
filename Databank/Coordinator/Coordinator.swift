//
//  Coordinator.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set}
    func start()
}
