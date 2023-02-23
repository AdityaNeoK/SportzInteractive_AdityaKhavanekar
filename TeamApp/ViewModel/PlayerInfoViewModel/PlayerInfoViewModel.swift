//
//  PlayerInfoViewModel.swift
//  TeamApp
//
//  Created by APPLE on 23/02/23.
//

import Foundation

class PlayerInfoViewModel{
    
    private var player:Player?
    
    //init: Constructor DI
    init(player: Player? = nil) {
        self.player = player
    }
    
    // Get selected player Info
    func getPlayerInfo()->Player?{
        return self.player
    }
    
    // Get selected player Batting Stat
    func getBattingStat() -> Batting?{
        return self.player?.batting
    }
    
    // Get selected player bowling Stat
    func getBowlingStat() -> Bowling?{
        return self.player?.bowling
    }
}
