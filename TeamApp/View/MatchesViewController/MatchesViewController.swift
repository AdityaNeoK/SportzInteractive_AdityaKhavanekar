//
//  MatchesViewController.swift
//  TeamApp
//
//  Created by APPLE on 21/02/23.
//

import UIKit

class MatchesViewController: UIViewController {

    @IBOutlet weak var matchesTableView: UITableView? {
        didSet{
            self.matchesTableView?.delegate = self
            self.matchesTableView?.dataSource = self
            self.matchesTableView?.register(UINib(nibName: TableViewCellConstants.matchesTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCellConstants.matchesTableViewCell)
        }
    }
    var matchViewModel : MatchesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAllMatches()
    }
 
    private func setupUI(){
        self.title = TitleConstants.allMatchesTitle
    }
    
    private func getAllMatches(){
        matchViewModel?.getAllMatches()
    }
}

extension MatchesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchViewModel?.getMatchesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellConstants.matchesTableViewCell) as? MatchTableViewCell else {return UITableViewCell()}
        cell.setupCell(model: self.matchViewModel?.getMattchAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.matchViewModel?.getMattchAtIndex(index: indexPath.row) else {return}
        let vc = MatchInfoViewController()
        vc.matchInfoViewModel = MatchInfoViewModel(matchDetailModel: model)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension MatchesViewController:MatchesProtocol{
    func onSuccess() {
        DispatchQueue.main.async {
            self.matchesTableView?.reloadData()
        }
    }
    
    func onFailure(error:String) {
        let alert = UIAlertController(title: StringConstants.error, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstants.ok, style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
