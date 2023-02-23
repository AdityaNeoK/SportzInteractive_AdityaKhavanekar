//
//  PlayerInfoViewController.swift
//  TeamApp
//
//  Created by APPLE on 23/02/23.
//

import UIKit

class PlayerInfoViewController: UIViewController {
    //Outlets
    @IBOutlet weak var statsSegmentControl: UISegmentedControl!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var statOneLbl: UILabel!
    @IBOutlet weak var statTwoLbl: UILabel!
    @IBOutlet weak var statThreeLbl: UILabel!
    @IBOutlet weak var statFourLbl: UILabel!
    
    @IBOutlet weak var statOneInfoLbl: UILabel!
    @IBOutlet weak var statTwoInfoLbl: UILabel!
    @IBOutlet weak var statThreeInfoLbl: UILabel!
    @IBOutlet weak var statFourInfoLbl: UILabel!
    
    //Variables
    var playerInfoViewModel:PlayerInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //Segment Action
    @IBAction func statSelected(_ sender: UISegmentedControl) {
        switch self.statsSegmentControl.selectedSegmentIndex{
        case 0:
            self.setupBatting()
        case 1:
            self.setupBowling()
        default:
            break
        }
    }
    
    //Dismiss Action
    @IBAction func dismissClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //UI Function
    private func setupUI(){
        self.setupSegmentControl()
        self.playerNameLbl.text = self.playerInfoViewModel?.getPlayerInfo()?.nameFull
    }
    
    //Setup Segmented Control
    private func setupSegmentControl(){
        
        self.statsSegmentControl.backgroundColor = .lightGray
        self.statsSegmentControl.selectedSegmentTintColor = .black
        self.statsSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self.statsSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        self.statsSegmentControl.setTitle(BattingStats.battingStats, forSegmentAt: 0)
        self.statsSegmentControl.setTitle(BowlingStats.bowlingStats, forSegmentAt: 1)
        
        switch self.statsSegmentControl.selectedSegmentIndex{
        case 0:
            self.setupBatting()
        case 1:
            self.setupBowling()
        default:
            break
        }
        
    }
    
    //set Statistics of the player
    private func setupBatting(){
        self.statOneLbl.text = BattingStats.style
        self.statTwoLbl.text = BattingStats.average
        self.statThreeLbl.text = BattingStats.rate
        self.statFourLbl.text = BattingStats.runs
        
        self.statOneInfoLbl.text = playerInfoViewModel?.getBattingStat()?.style.rawValue
        self.statTwoInfoLbl.text = playerInfoViewModel?.getBattingStat()?.average
        self.statThreeInfoLbl.text = playerInfoViewModel?.getBattingStat()?.strikerate
        self.statFourInfoLbl.text = playerInfoViewModel?.getBattingStat()?.runs
    }
    
    private func setupBowling(){
        self.statOneLbl.text = BowlingStats.style
        self.statTwoLbl.text = BowlingStats.average
        self.statThreeLbl.text = BowlingStats.economyRate
        self.statFourLbl.text = BowlingStats.wickets
        
        self.statOneInfoLbl.text = playerInfoViewModel?.getBowlingStat()?.style
        self.statTwoInfoLbl.text = playerInfoViewModel?.getBowlingStat()?.average
        self.statThreeInfoLbl.text = playerInfoViewModel?.getBowlingStat()?.economyrate
        self.statFourInfoLbl.text = playerInfoViewModel?.getBowlingStat()?.wickets
    }
}


