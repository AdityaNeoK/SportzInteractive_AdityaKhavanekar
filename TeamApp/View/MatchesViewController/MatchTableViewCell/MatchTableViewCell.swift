//
//  MatchTableViewCell.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var awayTeamNameLbl: UILabel!
    @IBOutlet weak var homeTeamNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Setup Cell
    func setupCell(model:MatchDetailModel?){
        self.venueLbl.text = model?.matchdetail.venue.name
        self.dateLbl.text = model?.matchdetail.match.date
        self.timeLbl.text = model?.matchdetail.match.time
        self.awayTeamNameLbl.text = model?.teams[model?.matchdetail.teamAway ?? ""]?.nameFull
        self.homeTeamNameLbl.text = model?.teams[model?.matchdetail.teamHome ?? ""]?.nameFull
    }
    
}
