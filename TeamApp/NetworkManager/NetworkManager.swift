//
//  NetworkManager.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import Foundation

class NetworkManager{
    
    
    // GET API Call
    func getDetails<T:Codable>(url:URL?,model:T.Type,completion:@escaping (Result<T, Error>)->()){
        let session = URLSession.shared
        if let url = url{
            let task = session.dataTask(with: url) { matchData, matchResponse, matchError in
                if matchError == nil{
                    let response = matchResponse as! HTTPURLResponse
                    if (response.statusCode == 200){
                        do{
                            let object = try JSONDecoder().decode(T.self, from: matchData!)
                            completion(.success(object))
                        }
                        catch let e{
                            debugPrint("Parsing error \(e)")
                            completion(.failure(e))
                        }
                    }
                    else{
                        completion(.failure(Error.self as! Error))
                    }
                }
            }
            task.resume()
        }
    }
    
}



