//
//  MatchModelView.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import Foundation

protocol MatchesProtocol:AnyObject{
    func onSuccess()
    func onFailure(error:String)
}

class MatchesViewModel{
    
//    Variables
    private var matchDetailArray = [MatchDetailModel]()
    private weak var delegate : MatchesProtocol?
    private var playerArray = [Player]()

    //init: Constructor DI
    init(delegate: MatchesProtocol? = nil) {
        self.delegate = delegate
    }

    
    //API REQUEST
    func getAllMatches(){
        let dispatchGroup = DispatchGroup()
        MatchEndPoints.allCases.forEach {
            let url = URL(string: $0.completeURL)
            dispatchGroup.enter()
            NetworkManager.sharedInstance.getDetails(url:url,model: MatchDetailModel.self) { result in
                switch result {
                case .success(let data):
                    self.matchDetailArray.append(data)
                    self.delegate?.onSuccess()
                    break
                case .failure(let error):
                    self.delegate?.onFailure(error: error.localizedDescription)
                    break
                }
                dispatchGroup.leave()
            }
        }
    }
    
    //Get match countt
    func getMatchesCount()->Int{
        return matchDetailArray.count
    }
    
    // Get match at specific index
    func getMattchAtIndex(index:Int) -> MatchDetailModel{
        return matchDetailArray[index]
    }
    
}
