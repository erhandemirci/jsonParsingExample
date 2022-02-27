//
//  ServiceAPI.swift
//  TheMovieApp
//
//  Created by CİHAN ÖZTÜRK on 29.01.2021.
//  Copyright © 2021 CİHAN ÖZTÜRK. All rights reserved.
//

import Foundation

protocol BaseRequest: Codable {
    var requestURL: String { get set }
}

final class ServiceAPI: NSObject {
    
    static let shared: ServiceAPI = {
        let shared = ServiceAPI()
        return shared
    }()
    
    func callService<T: Codable>(request: BaseRequest, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: URL(string: request.requestURL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            guard let data = data else {
                completion(.failure(error! as! Error))
                return
            }
           // debugPrint("convertedJsonIntoDict",self.convertJsonDataToDict(data: data) ?? "nil")

            //self.convertJsonDataToDict(data: data)
            let result = Result {
                try JSONDecoder().decode(T.self, from: data)
            }
            completion(result
)
        }
        task.resume()
    }
    
    func convertJsonDataToDict(data: Data?) -> NSDictionary? {
        
        guard let data = data else {
            return nil
        }
        do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                return convertedJsonIntoDict
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
}



