//
//  NetworkManager.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import Foundation

class NetworkManager{
    
    static var sharedInstance = NetworkManager()
    
    private init(){}
    
    // GET API Call
    func getDetails<T:Codable>(url:URL?,model:T.Type,completion:@escaping (Result<T, Error>)->()){
        let session = URLSession.shared
        if let url = url{
            let task = session.dataTask(with: url) { matchData, matchResponse, matchError in
                if matchError == nil{
                    do{
                        let object = try JSONDecoder().decode(model.self, from: matchData!)
                        completion(.success(object))
                    }
                    catch let e{
                        debugPrint("Parsing error \(e)")
                        completion(.failure(e))
                    }
                }
                else{
                    if let er = matchError{
                        completion(.failure(er))
                    }
                }
            }
            task.resume()
        }
    }
    
}



