//
//  Subject.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import Foundation

struct SubjectModel: Codable {
    let id, subjectDescription: String?
    let active, hasSubjects: Bool?
    let subjects: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case subjectDescription = "description"
        case active, hasSubjects, subjects
    }
}


