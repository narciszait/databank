//
//  APIClient.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import Foundation

enum ServerURLs: String {
    case subjects = "https://api.statbank.dk/v1/subjects?"
    case tables =  "https://api.statbank.dk/v1/tables?"
    case graphs = "https://api.statbank.dk/v1/data/"
}

enum Parameters: String {
    case language = "lang"
    case format = "format"
    case withoutNoDataTables = "omitSubjectsWithoutTables"
    case subjectID = "subjects"
    case PNGformat = "PNG"
    case valuePresentation = "valuePresentation" //CodeAndValue
    case timeOrder = "timeOrder" //Descending
}

enum MandatoryParameters: String {
    case beskstatus = "beskstatus"
    case kandidat = "kandidat"
    case indikator = "indikator"
    case enhed = "enhed"
    case tal = "tal"
    case bedrift = "bedrift"
    case indud = "indud"
    case sæson = "sæson"
    case transakt = "transakt"
    case prisenhed = "prisenhed"
    case løbetid = "løbetid"
    case værdian = "værdian"
    case data = "data"
    case aktivitet = "aktivitet"
    case type = "type"
}

enum MakeURLError: Error {
    case couldNotMakeURL
}

struct APIClient {
    var fetchSubjects = fetchSubjects(completion: )
    var fetchTables = fetchTables(subjectID: completion: )
    var fetchGraph = fetchGraph(tableID: subjectID: variables: completion: )
}

private func fetchSubjects(completion: @escaping (Result<[SubjectModel], Error>) -> Void) {
    dataTask(ServerURLs.subjects.rawValue, parameters: [Parameters.language.rawValue: "en",
                                                        Parameters.format.rawValue: "JSON",
                                                        Parameters.withoutNoDataTables.rawValue : "true"],
             completionHandler: completion)
}

private func fetchTables(subjectID: String, completion: @escaping (Result<[TableModel], Error>) -> Void) {
    dataTask(ServerURLs.tables.rawValue, parameters: [Parameters.language.rawValue: "en",
                                                      Parameters.subjectID.rawValue: subjectID,
                                                      Parameters.format.rawValue: "JSON"],
             completionHandler: completion)
}

private func fetchGraph(tableID: String, subjectID: String, variables: [String], completion: @escaping (Result<URL, MakeURLError>) -> Void) {
    var parameters = [Parameters.language.rawValue: "en",
                      Parameters.valuePresentation.rawValue: "CodeAndValue",
                      Parameters.timeOrder.rawValue: "Descending"]
    
    switch subjectID {
    case "01", "02", "03":
        break
    case "04":
        parameters[MandatoryParameters.beskstatus.rawValue] = "*"
    case "05":
        parameters[MandatoryParameters.kandidat.rawValue] = "*"
        parameters[MandatoryParameters.indikator.rawValue] = "*"
    case "06":
        parameters[MandatoryParameters.enhed.rawValue] = "*"
    case "07":
        parameters[MandatoryParameters.tal.rawValue] = "*"
    case "11":
        parameters[MandatoryParameters.tal.rawValue] = "*"
        parameters[MandatoryParameters.bedrift.rawValue] = "*"
    case "13":
        parameters[MandatoryParameters.indud.rawValue] = "*"
        parameters[MandatoryParameters.sæson.rawValue] = "*"
    case "14":
        parameters[MandatoryParameters.transakt.rawValue] = "*"
        parameters[MandatoryParameters.prisenhed.rawValue] = "*"
    case "16":
        parameters[MandatoryParameters.løbetid.rawValue] = "*"
        parameters[MandatoryParameters.værdian.rawValue] = "*"
        parameters[MandatoryParameters.data.rawValue] = "*"
    case "18":
        parameters[MandatoryParameters.aktivitet.rawValue]  = "*"
    default:
        break
    }
    
//    for variable in variables {
//        parameters[variable] = "*"
//    }
    
    let items: [URLQueryItem] = parameters.map { (arg) -> URLQueryItem in let (key, value) = arg; return URLQueryItem.init(name: key, value: "\(value)") }
    var comps = URLComponents.init(string: "\(ServerURLs.graphs.rawValue)/\(tableID)/\(Parameters.PNGformat.rawValue)")!
    comps.queryItems = items
    let request = URLRequest.init(url: comps.url!)
    
    if let url = request.url {
        completion(.success(url))
    } else {
        completion(.failure(.couldNotMakeURL))
    }
    
    
//    dataTask("\(ServerURLs.graphs.rawValue)/\(tableID)/PNG?", parameters: parameters, completionHandler: completion)
}

private func dataTask<T: Decodable>(_ path: String, parameters: [String: Any] = [:], completionHandler: (@escaping (Result<T, Error>) -> Void)) {
    
    let request: URLRequest
    
    if parameters.isEmpty {
        request = URLRequest(url: URL(string: path)!)
    } else {
        let items: [URLQueryItem] = parameters.map { (arg) -> URLQueryItem in let (key, value) = arg; return URLQueryItem.init(name: key, value: "\(value)") }
        var comps = URLComponents.init(string: path)!
        comps.queryItems = items
        request = .init(url: comps.url!)
        
    }
    
    URLSession.shared.dataTask(with: request) { data, _, error in
        handleDataResponse(data: data, error: error, completion: completionHandler)
    }.resume()
}

private func handleDataResponse<Output: Decodable>(data: Data?, error: Error?, completion: @escaping (Result<Output, Error>) -> Void) {
    DispatchQueue.main.async {
        do {
            if let error = error {
                throw error
            } else if let data = data {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                decoder.keyDecodingStrategy = .useDefaultKeys
                decoder.dateDecodingStrategy = .formatted(formatter) //.iso8601
                let result: Result<Output, Error> = .success(try decoder.decode(Output.self, from: data))
                completion(result)
                
            } else {
                fatalError()
            }
        } catch let finalError {
            completion(.failure(finalError))
        }
    }
}
