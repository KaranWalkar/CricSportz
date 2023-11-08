//
//  ViewController.swift
//  SportzCric
//
//  Created by Smollan Karan on 07/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var matchTeamTableView: UITableView!
    
    var allDataArr = [Welcome]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.prepareData()
    }

    func prepareData() {
        let vm = TeamsViewModel()
        vm.getAllMatchData { withsuccess in
            self.allDataArr = withsuccess
            self.prepareView()
        }
    }

    func prepareView() {
        self.matchTeamTableView.backgroundColor = .clear
        self.matchTeamTableView.register(UINib(nibName: "MatchTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchTeamTableViewCell")
        self.matchTeamTableView.delegate = self
        self.matchTeamTableView.dataSource = self
        self.matchTeamTableView.reloadData()
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "MatchTeamTableViewCell") as? MatchTeamTableViewCell else {
            return MatchTeamTableViewCell()
        }
        let vm = TeamsViewModel()
        vm.setupMatchTeamCell(tableCell: cell, data: self.allDataArr[indexPath.row], vc: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let teamPlayersVC = storyboard.instantiateViewController(withIdentifier: "TeamPlayersViewController") as! TeamPlayersViewController
//        teamPlayersVC.allDatatArray = allDataArr
        var t = [Team]()
        for team in self.allDataArr[indexPath.row].teams.values {
            t.append(team)
        }
        teamPlayersVC.arrayTeamData = t
        self.navigationController?.pushViewController(teamPlayersVC, animated: true)
    }
}
