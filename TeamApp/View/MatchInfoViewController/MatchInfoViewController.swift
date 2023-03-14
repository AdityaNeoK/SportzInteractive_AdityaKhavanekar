//
//  MatchInfoViewController.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import UIKit

class MatchInfoViewController: UIViewController {
    //    Outlets
    @IBOutlet weak var TitleStackView: UIStackView!
    @IBOutlet weak var awayTeamLbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var SquadSegmentControl: UISegmentedControl!
    
    var matchInfoViewModel : MatchInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
    }
    
    // SegmentedControl Action
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        switch SquadSegmentControl.selectedSegmentIndex{
        case 0:
            self.playerTableView.reloadData()
        case 1:
            self.playerTableView.reloadData()
        case 2:
            self.playerTableView.reloadData()
        default:
            print("")
        }
    }
    
    // UI setup
    private func setupUI(){
        self.SquadSegmentControl.backgroundColor = .lightGray
        self.SquadSegmentControl.selectedSegmentTintColor = .black
        self.SquadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self.SquadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        self.SquadSegmentControl.setTitle(self.matchInfoViewModel?.getMatchDetail()?.teams[self.matchInfoViewModel?.getMatchDetail()?.matchdetail.teamHome ?? ""]?.nameFull, forSegmentAt: 0)
        self.SquadSegmentControl.setTitle(self.matchInfoViewModel?.getMatchDetail()?.teams[self.matchInfoViewModel?.getMatchDetail()?.matchdetail.teamAway ?? ""]?.nameFull, forSegmentAt: 1)
        self.SquadSegmentControl.setTitle(StringConstants.all, forSegmentAt: 2)
        
        self.title = TitleConstants.matchInfoTitle
        self.homeTeamLbl.text = "\(self.matchInfoViewModel?.getTeamDetails(team: .home)?.nameFull ?? "")"
        self.awayTeamLbl.text = "\(self.matchInfoViewModel?.getTeamDetails(team: .away)?.nameFull ?? "")"
        self.TitleStackView.layer.cornerRadius = 10
        
    }
    private func setupTableView(){
        self.playerTableView.delegate = self
        self.playerTableView.dataSource = self
        self.playerTableView.separatorStyle = .none
        self.playerTableView.register(UINib(nibName: TableViewCellConstants.playerTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCellConstants.playerTableViewCell)
    }
    
    private func showPlayerInfoAlert(player:Player?){
        if let player = player{
            let infoAlert = UIAlertController(title: player.nameFull, message: "\(StringConstants.battingStyle): \(player.batting.style.rawValue) \(StringConstants.newLine) \(StringConstants.bowlingStyle): \(player.bowling.style)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: StringConstants.ok, style: .default)
            infoAlert.addAction(okAction)
            self.present(infoAlert, animated: true)
        }
    }
}

//MARK: -  TableView UITableViewDelegate UITableViewDataSource
extension MatchInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.SquadSegmentControl.selectedSegmentIndex{
        case 0:
            return self.matchInfoViewModel?.getPlayerCount(team: .home) ?? 0
        case 1:
            return self.matchInfoViewModel?.getPlayerCount(team: .away) ?? 0
        case 2:
            return self.matchInfoViewModel?.getPlayerCount(team: .all) ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellConstants.playerTableViewCell) as? PlayerTableViewCell else {return UITableViewCell()}
        switch self.SquadSegmentControl.selectedSegmentIndex{
        case 0:
            if let homePlayer = self.matchInfoViewModel?.getPlayer(team: .home, index: indexPath){
                cell.setupCell(player: homePlayer)
            }
        case 1:
            if let awayPlayer = self.matchInfoViewModel?.getPlayer(team: .away, index: indexPath){
                cell.setupCell(player: awayPlayer)
            }
        case 2:
            if let allPlayers = self.matchInfoViewModel?.getPlayer(team: .all, index: indexPath){
                cell.setupCell(player: allPlayers)
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerScreen = PlayerInfoViewController()
        switch self.SquadSegmentControl.selectedSegmentIndex{
        case 0:
            let player = self.matchInfoViewModel?.getPlayer(team: .home, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
            self.showPlayerInfoAlert(player: player)
        case 1:
            let player = self.matchInfoViewModel?.getPlayer(team: .away, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
            self.showPlayerInfoAlert(player: player)
        case 2:
            let player = self.matchInfoViewModel?.getPlayer(team: .all, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
//            self.showPlayerInfoAlert(player: player)
        default:
            print("error")
        }
    }
}
