//
//  MatchInfoViewModel.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import Foundation

class MatchInfoViewModel{
    
    var matchDetailModel:MatchDetailModel?
    
    init(matchDetailModel:MatchDetailModel){
        self.matchDetailModel = matchDetailModel
    }
    
    private var teamHomePlayers: [Player]? {
        return self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamHome ?? ""]?.players.values.map({ return $0 })
    }
    
    private var teamAwayPlayers: [Player]?{
        return self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamAway ?? ""]?.players.values.map({ return $0 })
    }
    
    private var allPlayers: [Player]?{
        var all = [Player]()
        guard let homePlayers = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamHome ?? ""]?.players.values.map({ return $0 }) else { return nil }
        guard let awayPlayers = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamAway ?? ""]?.players.values.map({ return $0 }) else { return nil }
        all.append(contentsOf: homePlayers)
        all.append(contentsOf: awayPlayers)
        return all
    }
    
    init(matchDetailModel: MatchDetailModel? = nil) {
        self.matchDetailModel = matchDetailModel
    }
    
    func getTeamDetails(team:SelectTeam)->Team?{
        
        guard let homeTeam = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamHome ?? ""],let awayTeam = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamAway ?? ""] else {return nil}
        
        switch team{
        case .home:
            return homeTeam
        case .away:
            return awayTeam
        case .all:
            return nil
        }
    }
    
    func getPlayerCount(team:SelectTeam)->Int{
        
        guard let awayCount = getTeamDetails(team: .away)?.players.count,
              let homeCount = getTeamDetails(team: .home)?.players.count else { return 0 }
        
        switch team{
            
        case .home:
            return homeCount
        case .away:
            return awayCount
        case .all:
            return homeCount + awayCount
            
        }
    }
    
    func getPlayer(team:SelectTeam,index:IndexPath)->Player?{
        switch team{
        case .home:
            return teamHomePlayers?[index.row] ?? nil
        case .away:
            return teamAwayPlayers?[index.row] ?? nil
        case .all:
            return allPlayers?[index.row] ?? nil
        }
    }
}

enum SelectTeam{
    case home
    case away
    case all
}
