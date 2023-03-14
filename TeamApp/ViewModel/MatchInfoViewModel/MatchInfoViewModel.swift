//
//  MatchInfoViewModel.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import Foundation

class MatchInfoViewModel{
//    Variables
    private var matchDetailModel:MatchDetailModel?
    
    private var teamHomePlayers: [Player]? {
        return self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamHome ?? ""]?.players.values.map({ return $0 })
    }
    
    private var teamAwayPlayers: [Player]?{
        return self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamAway ?? ""]?.players.values.map({ return $0 })
    }
    
    private var allPlayers: [Player]?{
        guard let homePlayers = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamHome ?? ""]?.players.values.map({ return $0 }) else { return nil }
        guard let awayPlayers = self.matchDetailModel?.teams[self.matchDetailModel?.matchdetail.teamAway ?? ""]?.players.values.map({ return $0 }) else { return nil }
        return homePlayers+awayPlayers
    }
    
    //init: Constructor DI
    init(matchDetailModel:MatchDetailModel?=nil){
        self.matchDetailModel = matchDetailModel
    }
    
//    Get whole match detail
    func getMatchDetail()->MatchDetailModel?{
        return self.matchDetailModel
    }
    
//    Get team detail of the match selected
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
    
//    Get player count of the team selected
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
    
//    Get specific player information
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
