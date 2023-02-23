//
//  MatchInfoViewController.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import UIKit

class MatchInfoViewController: UIViewController {

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
    
    private func setupUI(){
        SquadSegmentControl.backgroundColor = .lightGray
        SquadSegmentControl.selectedSegmentTintColor = .black
        SquadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        SquadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        SquadSegmentControl.setTitle(self.matchInfoViewModel?.matchDetailModel?.teams[self.matchInfoViewModel?.matchDetailModel?.matchdetail.teamHome ?? ""]?.nameFull, forSegmentAt: 0)
        SquadSegmentControl.setTitle(self.matchInfoViewModel?.matchDetailModel?.teams[self.matchInfoViewModel?.matchDetailModel?.matchdetail.teamAway ?? ""]?.nameFull, forSegmentAt: 1)
        SquadSegmentControl.setTitle(StringConstants.all, forSegmentAt: 2)
        
        self.title = TitleConstants.matchInfoTitle
        self.homeTeamLbl.text = "\(self.matchInfoViewModel?.getTeamDetails(team: .home)?.nameFull ?? "")"
        self.awayTeamLbl.text = "\(self.matchInfoViewModel?.getTeamDetails(team: .away)?.nameFull ?? "")"
        self.TitleStackView.layer.cornerRadius = 10
        
    }
    private func setupTableView(){
        self.playerTableView.delegate = self
        self.playerTableView.dataSource = self
        self.playerTableView.register(UINib(nibName: TableViewCellConstants.playerTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCellConstants.playerTableViewCell)
    }
    
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
}

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
            print(self.matchInfoViewModel?.getPlayer(team: .home, index: indexPath)?.nameFull ?? "")
            let player = self.matchInfoViewModel?.getPlayer(team: .home, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
        case 1:
            print(self.matchInfoViewModel?.getPlayer(team: .away, index: indexPath)?.nameFull ?? "")
            let player = self.matchInfoViewModel?.getPlayer(team: .away, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
        case 2:
            print(self.matchInfoViewModel?.getPlayer(team: .all, index: indexPath)?.nameFull ?? "")
            let player = self.matchInfoViewModel?.getPlayer(team: .all, index: indexPath)
            playerScreen.playerInfoViewModel = PlayerInfoViewModel(player: player)
            playerScreen.modalPresentationStyle = .overFullScreen
            self.present(playerScreen, animated: true)
        default:
            print("error")
        }
    }
    
}
