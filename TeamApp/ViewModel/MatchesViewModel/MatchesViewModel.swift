//
//  MatchModelView.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import Foundation

protocol MatchesProtocol{
    func onSuccess()
    func onFailure(error:String)
}

class MatchesViewModel{
    
    private let networkManager = NetworkManager()
    private var matchDetailArray = [MatchDetailModel]()
    private var delegate : MatchesProtocol?
    
    //Detail View
    private var playerArray = [Player]()

    
    init(delegate: MatchesProtocol? = nil) {
        self.delegate = delegate
    }

    
    //API REQUEST
    func getAllMatches(){
        let dispatchGroup = DispatchGroup()
        MatchEndPoints.allCases.forEach {
            let url = URL(string: $0.completeURL)
            dispatchGroup.enter()
            networkManager.getDetails(url:url,model: MatchDetailModel.self) { result in
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
    
    //FUNCTIONS Home Screen
    func getMatchesCount()->Int{
        return matchDetailArray.count
    }
    func getMattchAtIndex(index:Int) -> MatchDetailModel{
        return matchDetailArray[index]
    }
}
