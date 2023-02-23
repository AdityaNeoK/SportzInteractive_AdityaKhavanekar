//
//  PlayerInfoViewModel.swift
//  TeamApp
//
//  Created by APPLE on 23/02/23.
//

import Foundation

class PlayerInfoViewModel{
    var player:Player?
    
    init(player: Player? = nil) {
        self.player = player
    }
    
    func getBattingStat() -> Batting?{
        return self.player?.batting
    }
    func getBowlingStat() -> Bowling?{
        return self.player?.bowling
    }
}
