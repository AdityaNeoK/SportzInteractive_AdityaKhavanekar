//
//  PlayerTableViewCell.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var playerExtraInfoLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerExtraInfoLbl.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // Setup Cell
    func setupCell(player:Player){
        self.playerNameLbl.text = player.nameFull
        if let captain = player.iscaptain,let keeper = player.iskeeper{
            if captain && keeper{
                self.playerExtraInfoLbl.isHidden = false
                self.playerExtraInfoLbl.text = CheckCaptainKeeper.Both
            }
            else{
                self.playerExtraInfoLbl.isHidden = true
            }
        }
        else if let captain = player.iscaptain{
            if captain{
                self.playerExtraInfoLbl.isHidden = false
                self.playerExtraInfoLbl.text = CheckCaptainKeeper.captain
            }
            else{
                self.playerExtraInfoLbl.isHidden = true
            }
        }
        else if let keeper = player.iskeeper{
            if keeper{
                self.playerExtraInfoLbl.isHidden = false
                self.playerExtraInfoLbl.text = CheckCaptainKeeper.keeper
            }
            else{
                self.playerExtraInfoLbl.isHidden = true
            }
        }
        else{
            self.playerExtraInfoLbl.text = nil
            self.playerExtraInfoLbl.isHidden = true
        }
    }
    
}


