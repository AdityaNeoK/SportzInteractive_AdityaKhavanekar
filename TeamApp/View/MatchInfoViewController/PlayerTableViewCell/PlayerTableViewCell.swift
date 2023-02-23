//
//  PlayerTableViewCell.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerExtraInfoLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerExtraInfoLbl.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCell(player:Player){
        self.playerNameLbl.text = player.nameFull
        if let captain = player.iscaptain{
            self.playerExtraInfoLbl.isHidden = false
            if let keeper = player.iskeeper{
                if captain && keeper{
                    self.playerExtraInfoLbl.text = "C & WK"
                }
                else if captain && (keeper == false){
                    self.playerExtraInfoLbl.text = "C"
                }
                else if captain == false && keeper{
                    self.playerExtraInfoLbl.text = "WK"
                }
            }
            else if captain{
                self.playerExtraInfoLbl.text = "C"
            }
        }
        else{
            self.playerExtraInfoLbl.isHidden = true
        }
    }
    
}

enum CheckCaptainKeeper:String,CaseIterable{
    case captain = "(C)"
    case keeper = "(WK)"
    case Both = "(C)(WK)"
}
