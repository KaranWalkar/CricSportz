//
//  TeamPlayersViewController.swift
//  SportzCric
//
//  Created by Smollan Karan on 08/11/23.
//

import UIKit

class TeamPlayersViewController: UIViewController {

    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var playersTableView: UITableView!
    
    var arrayTeamData = [Team]()
    var playersArr = [Player]()
    var selectedTeam = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.performOperation(index: self.selectedTeam)
    }
    
    func prepareView() {
        self.playersTableView.backgroundColor = .clear
        
        self.teamCollectionView.delegate = self
        self.teamCollectionView.dataSource = self
        self.teamCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        
        self.playersTableView.delegate = self
        self.playersTableView.dataSource = self
        self.playersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        
        self.playersTableView.reloadData()
        self.teamCollectionView.reloadData()
    }
    
    func performOperation(index: Int) {
        self.playersArr.removeAll()
        let playersList = self.arrayTeamData[index].players
        for i in playersList {
            let a = i.value
            self.playersArr.append(a)
        }
        self.playersArr = self.playersArr.sorted {
            Int($0.position) ?? 0 < Int($1.position) ?? 0
        }
        
        self.prepareView()
    }

}

extension TeamPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else {
            return PlayerTableViewCell()
        }
        let vm = TeamsViewModel()
        vm.setupCellTeamsPlayers(tableCell: cell, player: self.playersArr[indexPath.row])
        
        return cell
    }
    
}

extension TeamPlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as? TeamCollectionViewCell else {
            return TeamCollectionViewCell()
        }
        cell.nameLabel.textColor = .gray
        cell.nameLabel.tintColor = .gray
        cell.underlineView.backgroundColor = .clear
        if indexPath.row == self.selectedTeam {
            cell.nameLabel.textColor = .white
            cell.nameLabel.tintColor = .white
            cell.underlineView.backgroundColor = .white
        }
        cell.nameLabel.text = self.arrayTeamData[indexPath.row].nameFull
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTeam = indexPath.row
        self.performOperation(index: self.selectedTeam)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2)-10, height: collectionView.frame.size.height)
    }
}
