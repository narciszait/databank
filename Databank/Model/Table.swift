//
//  Table.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import Foundation

struct TableModel: Codable {
    let id, text, unit, updated: String?
    let firstPeriod, latestPeriod: String?
    let active: Bool?
    let variables: [String]?
}
